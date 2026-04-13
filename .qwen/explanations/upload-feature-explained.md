# Upload Feature — Complete Explanation

## Overview

The upload feature allows users to select medical images (via image picker or drag-and-drop) and upload them to a server. It supports both **native platforms** (Android/iOS) and **web**, with platform-specific implementations chosen at compile time.

---

## Folder Structure

```
lib/feature/upload/
│
├── data/
│   ├── models/
│   │   ├── info_item_model.dart          # Model for info cards (formats, privacy, AI analysis)
│   │   ├── nav_model.dart                # Navigation bar model
│   │   └── upload_response_model.dart    # API response: id, filename, ownerId
│   │
│   ├── repo/
│   │   └── upload_repo_impl.dart         # Repository implementation (@LazySingleton)
│   │
│   └── service/remote/
│       ├── upload_remote_medical_service.dart   # Abstract interface
│       ├── upload_api_medical_service.dart      # Native implementation (background_downloader)
│       ├── upload_web_medical_service.dart      # Web implementation (Dio)
│       ├── upload_service_factory.dart          # Conditional export entry point
│       ├── upload_service_factory_native.dart   # Factory for native platforms
│       └── upload_service_factory_stub.dart     # Factory for web platform
│
├── domain/
│   └── upload_repo.dart                  # Abstract repository interface
│
├── presentation/
│   ├── cubit/
│   │   ├── upload_images_cubit.dart      # Manages selected images list
│   │   ├── upload_process_cubit.dart     # Manages upload lifecycle (@injectable)
│   │   └── upload_process_states.dart    # Sealed class: Idle, InProgress, Success, Failure
│   │
│   ├── screens/
│   │   └── upload_screen.dart            # Main screen with MultiBlocProvider
│   │
│   └── widgets/
│       ├── upload_item.dart              # Root widget: DropTarget + BlocBuilder
│       ├── upload_empty_state.dart       # Drag-and-drop zone (no images)
│       ├── upload_has_images_state.dart   # Grid + upload button + status banners
│       ├── upload_button.dart            # "Select File" button
│       ├── upload_images_button.dart     # "Upload Images" action button
│       ├── compact_image_grid.dart       # 4-column thumbnail grid
│       ├── compact_thumbnail.dart        # Individual thumbnail with remove button
│       ├── images_header_row.dart        # "Selected Images (N)" + "Clear All"
│       ├── add_more_strip.dart           # "Add More Images" inline button
│       ├── custom_container.dart         # Styled dark theme wrapper
│       ├── custom_nav_bar.dart           # Bottom/desktop navigation
│       ├── nav_bar_item.dart             # Navigation destination with SVG icons
│       ├── info_item.dart                # Single info card
│       ├── info_item_row.dart            # Desktop info cards (horizontal)
│       ├── info_item_column.dart         # Mobile info cards (vertical)
│       ├── before_search.dart            # Triggers search overlay
│       └── before_search_item.dart       # Search bar placeholder UI
│
└── shared/
    └── upload_page.dart                  # Responsive page wrapper (desktop vs mobile)
```

---

## Architecture Layers

### 1. Domain Layer — `upload_repo.dart`

The **abstract interface** that defines what the upload feature can do:

```dart
abstract class UploadRepo {
  Future<Either<Failure, List<UploadResponseModel>>> uploadImages(List<String> filePaths);
  Stream<double> get progressStream;
  void cancelUpload();
  Future<bool> hasActiveUpload();
}
```

| Method | Return Type | Description |
|---|---|---|
| `uploadImages(filePaths)` | `Either<Failure, List<UploadResponseModel>>` | Upload a list of file paths. Uses `dartz.Either` for functional error handling — Left = Failure, Right = success results |
| `progressStream` | `Stream<double>` | Broadcast stream emitting progress values from 0.0 to 1.0 (or -1 for indeterminate) |
| `cancelUpload()` | `void` | Aborts any currently running upload |
| `hasActiveUpload()` | `Future<bool>` | Checks if a background upload exists (useful for native where uploads survive app restarts) |

---

### 2. Data Layer

#### Repository Implementation — `upload_repo_impl.dart`

```dart
@LazySingleton(as: UploadRepo)
class UploadRepoImpl implements UploadRepo {
  final UploadRemoteMedicalService _remoteService;
  // ... delegates everything to _remoteService
  // Wraps exceptions in Failure objects via dartz
}
```

- Registered as a **lazy singleton** via `injectable`
- Acts as a thin wrapper — delegates all work to the platform-specific remote service
- Converts raw exceptions into `Failure` objects for the domain layer

---

#### Platform-Specific Services

Both implementations conform to the `UploadRemoteMedicalService` interface.

---

##### NATIVE: `upload_api_medical_service.dart`

Used on **Android and iOS** devices.

**Key Technology:** `background_downloader` package

**Constructor:**
```dart
UploadApiMedicalService(this._authLocalService);
```
Takes `AuthLocalMedicalService` to retrieve the user's Bearer token.

**How it works:**

1. **Task Creation** — Creates a `MultiUploadTask` for each file:
   - URL = `ApiConstant.baseUrl + ApiConstant.uploadImageEndpoint`
   - Includes `Authorization: Bearer <token>` header
   - Includes `ngrok-skip-browser-warning` header (for dev behind ngrok)
   - Groups all tasks under `'medical_image_upload'`

2. **Enqueue** — Tasks are enqueued via `FileDownloader().enqueue()`

3. **Progress Tracking** — Listens to `FileDownloader().updates`:
   ```dart
   FileDownloader().updates.listen((update) {
     // update.task is either TaskStatus.progress, completed, failed, etc.
     // Emit progress to StreamController<double>
   });
   ```

4. **Result Collection** — Uses a `Completer<List<UploadResponseModel>>`:
   - When all tasks complete, the completer resolves with the parsed results
   - Converts stream-based callbacks into a clean `Future` return type

5. **Retry Logic** — Failed uploads retry up to **2 times**

6. **Background Persistence** — Uploads continue even if the app goes to the background or gets killed

**Key methods:**
| Method | Behavior |
|---|---|
| `enqueueUpload(filePaths)` | Creates MultiUploadTasks, enqueues them, returns Future of results |
| `cancelUpload()` | Cancels all tasks in the `'medical_image_upload'` group |
| `hasActiveUpload()` | Checks if any tasks exist in the `'medical_image_upload'` group |
| `progressStream` | Broadcast stream from FileDownloader updates |

---

##### WEB: `upload_web_medical_service.dart`

Used on **web browsers**.

**Key Technology:** `Dio` HTTP client

**Constructor:**
```dart
UploadWebMedicalService(this._apiClient);
```
Takes `ApiClient` (Dio wrapper).

**How it works:**

1. **File Reading** — Reads each file as bytes:
   ```dart
   final bytes = await file.readAsBytes();
   final multipartFile = MultipartFile.fromBytes(bytes, filename: file.name);
   ```

2. **FormData Construction** — Builds `FormData` object:
   ```dart
   final formData = FormData.fromMap({
     'files': [multipartFile1, multipartFile2, ...]
   });
   ```

3. **HTTP POST** — Sends via Dio:
   ```dart
   final response = await _apiClient.dio.post(
     url,
     data: formData,
     onSendProgress: (sent, total) {
       _progressController.add(sent / total);  // Emit progress
     },
     cancelToken: _cancelToken,
   );
   ```

4. **Response Parsing** — Parses JSON into `List<UploadResponseModel>`

**Key differences from native:**
| Feature | Native | Web |
|---|---|---|
| Upload mechanism | background_downloader | Dio FormData |
| Background support | Yes (survives app kill) | No (stops on page close) |
| Cancellation | Via task group | Via Dio CancelToken |
| Retry | Automatic (2x) | Manual (not implemented) |
| `hasActiveUpload()` | Checks task groups | Always returns `false` |

---

##### Conditional Export — `upload_service_factory.dart`

This is how Dart picks the right implementation at **compile time**:

```dart
// upload_service_factory.dart
export 'upload_service_factory_stub.dart'
    if (dart.library.io) 'upload_service_factory_native.dart';
```

- **On web** → `dart.library.io` is NOT available → exports `upload_service_factory_stub.dart` → returns `UploadWebMedicalService`
- **On native** (Android/iOS) → `dart.library.io` IS available → exports `upload_service_factory_native.dart` → returns `UploadApiMedicalService`

This is a **Dart conditional import pattern** — no runtime checks needed, the correct code is compiled for each platform.

---

#### Response Model — `upload_response_model.dart`

```dart
class UploadResponseModel {
  final int id;
  final String filename;
  final String ownerId;

  factory UploadResponseModel.fromJson(Map<String, dynamic> json) {
    return UploadResponseModel(
      id: json['id'],
      filename: json['filename'],
      ownerId: json['owner_id'],  // snake_case from server
    );
  }
}
```

Simple immutable data class. Note: `owner_id` comes as snake_case from the server but is stored as camelCase `ownerId` in Dart.

---

### 3. Presentation Layer

#### Cubits

**`upload_images_cubit.dart`** — Manages selected images

```dart
class UploadImagesCubit extends Cubit<List<XFile>> {
  void addImages(List<XFile> images) => emit([...state, ...images]);
  void removeImage(int index) => emit([...state]..removeAt(index));
  void clear() => emit([]);
}
```

Simple state holder. Created directly in the screen (not via DI).

---

**`upload_process_cubit.dart`** — Manages upload lifecycle (`@injectable`)

```dart
@injectable
class UploadProcessCubit extends Cubit<UploadProcessState> {
  final UploadRepo _uploadRepo;

  // Called on creation
  Future<void> init() async {
    final hasActive = await _uploadRepo.hasActiveUpload();
    if (hasActive) {
      _listenToProgress();  // Resume listening to background upload
    }
  }

  // Called when user taps "Upload Images"
  Future<void> upload(List<XFile> images) async {
    emit(UploadProcessInProgress(progress: 0));
    _listenToProgress();

    final filePaths = images.map((f) => f.path).toList();
    final result = await _uploadRepo.uploadImages(filePaths);

    result.fold(
      (failure) => emit(UploadProcessFailure(error: failure.message)),
      (results) => emit(UploadProcessSuccess(results)),
    );
  }

  void reset() => emit(UploadProcessIdle());
  void cancelUpload() { _uploadRepo.cancelUpload(); reset(); }
}
```

**State flow:**
```
UploadProcessIdle
  ↓ (user clicks Upload)
UploadProcessInProgress(progress: 0.0 → 0.1 → 0.5 → 1.0)
  ↓ (success or failure)
UploadProcessSuccess(results)  OR  UploadProcessFailure(error)
```

---

**`upload_process_states.dart`** — Sealed class hierarchy

```dart
sealed class UploadProcessState {}

class UploadProcessIdle extends UploadProcessState {}

class UploadProcessInProgress extends UploadProcessState {
  final double progress;  // -1 = indeterminate, 0.0-1.0 = determinate
}

class UploadProcessSuccess extends UploadProcessState {
  final List<UploadResponseModel> results;
}

class UploadProcessFailure extends UploadProcessState {
  final String error;
}
```

Using a **sealed class** ensures exhaustive pattern matching — the compiler warns you if you forget to handle a state.

---

#### Screen Setup — `upload_screen.dart`

```dart
class UploadScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => UploadImagesCubit([])),
        BlocProvider(create: (ctx) => serviceLocator<UploadProcessCubit>()..init()),
      ],
      child: UploadPage(),
    );
  }
}
```

- `UploadImagesCubit` — created directly (not from DI)
- `UploadProcessCubit` — resolved via `serviceLocator`, then `.init()` is called immediately to check for background uploads

---

#### Core Widget — `upload_item.dart`

```dart
class UploadItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DropTarget(
      onDragDone: (details) => _handleDrop(details),
      child: BlocListener<UploadImagesCubit, List<XFile>>(
        listener: (context, images) {
          context.read<UploadProcessCubit>().reset();  // Reset upload state when images change
        },
        child: BlocBuilder<UploadImagesCubit, List<XFile>>(
          builder: (context, images) {
            return images.isEmpty
                ? UploadEmptyState()
                : UploadHasImagesState(images: images);
          },
        ),
      ),
    );
  }
}
```

Responsibilities:
1. Wraps everything in a `DropTarget` for desktop drag-and-drop
2. Uses `BlocListener` to reset upload state whenever the image list changes
3. Uses `BlocBuilder` to switch between empty state and images state

---

#### Images State — `upload_has_images_state.dart`

```dart
class UploadHasImagesState extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UploadProcessCubit, UploadProcessState>(
      builder: (context, state) {
        return switch (state) {
          UploadProcessIdle() => UploadImagesButton(),
          UploadProcessInProgress(:final progress) => _UploadProgressIndicator(progress: progress),
          UploadProcessSuccess(:final results) => _UploadStatusBanner.success(results),
          UploadProcessFailure(:final error) => _UploadStatusBanner.failure(error),
        };
      },
    );
  }
}
```

Uses **pattern matching** on the sealed `UploadProcessState` class.

**Progress indicator behavior:**
- `progress == -1` → indeterminate linear progress bar (unknown total size)
- `progress >= 0` → determinate linear progress bar (0% → 100%)

**Success banner:** Green checkmark + "Upload completed" message

**Failure banner:** Red error icon + error message

---

## Complete Upload Flow — Step by Step

```
┌─────────────────────────────────────────────────────────────────┐
│ STEP 1: User selects images                                     │
├─────────────────────────────────────────────────────────────────┤
│  • Click "Select File" → ImagePicker.pickMultiImage()           │
│  • OR drag & drop files → DropTarget.onDragDone                 │
│  → UploadImagesCubit.addImages(files)                           │
└─────────────────────────────────────────────────────────────────┘
                              ↓
┌─────────────────────────────────────────────────────────────────┐
│ STEP 2: UI updates to show image grid                           │
├─────────────────────────────────────────────────────────────────┤
│  • BlocBuilder rebuilds → UploadHasImagesState                  │
│  • Shows CompactImageGrid with thumbnails                       │
│  • UploadProcessCubit.reset() called (via BlocListener)         │
│  • Upload button changes from "Select File" → "Upload Images"   │
└─────────────────────────────────────────────────────────────────┘
                              ↓
┌─────────────────────────────────────────────────────────────────┐
│ STEP 3: User clicks "Upload Images"                             │
├─────────────────────────────────────────────────────────────────┤
│  → UploadProcessCubit.upload(images)                            │
│    → emits UploadProcessInProgress(progress: 0)                 │
│    → subscribes to progressStream                               │
│    → converts XFile list to path list                           │
│    → calls _uploadRepo.uploadImages(filePaths)                  │
└─────────────────────────────────────────────────────────────────┘
                              ↓
┌─────────────────────────────────────────────────────────────────┐
│ STEP 4: Repository delegates to platform service                │
├─────────────────────────────────────────────────────────────────┤
│  → UploadRepoImpl.uploadImages()                                │
│    → calls UploadRemoteMedicalService.enqueueUpload(filePaths)  │
│    → wraps result in Either<Failure, List<UploadResponseModel>> │
└─────────────────────────────────────────────────────────────────┘
                              ↓
┌─────────────────────────────────────────────────────────────────┐
│ STEP 5: Platform-specific upload                                │
├──────────────────────┬──────────────────────────────────────────┤
│ NATIVE (mobile)      │ WEB (browser)                            │
├──────────────────────┼──────────────────────────────────────────┤
│ • Gets auth token    │ • Reads files as bytes                   │
│   from AuthLocal     │ • Creates MultipartFile objects          │
│ • Creates            │ • Builds FormData                        │
│   MultiUploadTask    │ • POSTs via Dio                          │
│ • Enqueues to        │ • onSendProgress emits                   │
│   FileDownloader     │   to progressStream                      │
│ • Listens to         │ • CancelToken for cancellation           │
│   FileDownloader     │                                          │
│   .updates           │                                          │
│ • Retries 2x on fail │                                          │
└──────────────────────┴──────────────────────────────────────────┘
                              ↓
┌─────────────────────────────────────────────────────────────────┐
│ STEP 6: Result handling                                         │
├─────────────────────────────────────────────────────────────────┤
│  SUCCESS:                                                       │
│    → Either.right(List<UploadResponseModel>)                    │
│    → UploadProcessCubit emits UploadProcessSuccess(results)     │
│    → UI shows green checkmark banner                            │
│                                                                 │
│  FAILURE:                                                       │
│    → Either.left(Failure)                                       │
│    → UploadProcessCubit emits UploadProcessFailure(error)       │
│    → UI shows red error message                                 │
└─────────────────────────────────────────────────────────────────┘
```

---

## Dependency Injection Wiring

Everything is wired up through `injectable` and `get_it`:

```
RegisterModule
  └── registerModule.uploadRemoteService(authLocalService, apiClient)
        → returns UploadApiMedicalService (native) OR UploadWebMedicalService (web)

Service Locator (lazySingleton):
  ┌── UploadRemoteMedicalService  ← platform-specific instance
  ├── UploadRepo                  ← UploadRepoImpl(remoteService)
  └── UploadProcessCubit          ← factory: UploadProcessCubit(repo)
```

In `service_locator.config.dart` (auto-generated):
```dart
gh.lazySingleton<UploadRemoteMedicalService>(
  () => registerModule.uploadRemoteService(
    get<AuthLocalMedicalService>(),
    get<ApiClient>(),
  ),
);

gh.lazySingleton<UploadRepo>(
  () => UploadRepoImpl(get<UploadRemoteMedicalService>()),
);

gh.factory<UploadProcessCubit>(
  () => UploadProcessCubit(get<UploadRepo>()),
);
```

---

## External Dependencies

| Package | Version | Purpose |
|---|---|---|
| `background_downloader` | ^8.5.5 | Native background file uploads with progress tracking and retry |
| `image_picker` | ^1.2.1 | Image selection from gallery or camera |
| `desktop_drop` | ^0.7.0 | Drag-and-drop file support on desktop platforms |
| `dio` | ^5.9.2 | HTTP client used for web uploads |
| `dartz` | ^0.10.1 | Functional programming — `Either` type for error handling |
| `flutter_bloc` | — | State management using Cubit pattern |
| `injectable` | — | Code generation for dependency injection |
| `get_it` | — | Service locator runtime |

---

## Key Design Patterns

### 1. Platform Abstraction via Conditional Imports
Single interface (`UploadRemoteMedicalService`), two implementations. The correct one is chosen at **compile time** using Dart's conditional export syntax. No runtime platform checks needed.

### 2. Background Upload Resilience (Native)
On mobile, uploads use `background_downloader` which runs in a separate isolate/service. This means:
- Uploads continue when the app goes to the background
- Uploads survive app crashes and can be resumed
- `hasActiveUpload()` checks for existing uploads on app launch

### 3. Progress Tracking via Broadcast Stream
A `StreamController<double>.broadcast()` allows multiple subscribers:
- The cubit listens to update the progress bar
- Other widgets can also listen without interfering
- Values: `-1` = indeterminate, `0.0` to `1.0` = determinate progress

### 4. Authentication Integration
The native service retrieves the Bearer token from `AuthLocalMedicalService` (local storage) and includes it in every upload request header.

### 5. Functional Error Handling with `dartz.Either`
Instead of try/catch, errors are modeled as a type:
```dart
Either<Failure, List<UploadResponseModel>>
```
- `Left(Failure)` = error case with error details
- `Right(results)` = success case with data
- Forces callers to handle both cases explicitly via `.fold()`

### 6. Sealed Class State Management
Using `sealed class UploadProcessState` ensures:
- All states are known at compile time
- Pattern matching is exhaustive (compiler warns if you miss a case)
- No invalid states possible (e.g., can't be both Success and Failure)

### 7. Repository Pattern
The domain layer depends on an **abstraction** (`UploadRepo`), not a concrete implementation. This allows:
- Easy testing (mock the interface)
- Swapping implementations without touching domain logic
- Clean separation of concerns

---

## UploadResponseModel

The data structure returned after a successful upload:

```dart
class UploadResponseModel {
  final int id;              // Server-generated ID for the uploaded file
  final String filename;     // Original filename
  final String ownerId;      // ID of the user who owns this file

  factory UploadResponseModel.fromJson(Map<String, dynamic> json) {
    return UploadResponseModel(
      id: json['id'] as int,
      filename: json['filename'] as String,
      ownerId: json['owner_id'] as String,  // snake_case from server
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'filename': filename,
      'owner_id': ownerId,  // Converted back to snake_case for JSON
    };
  }
}
```

---

## Error Handling

Errors flow through the layers as follows:

```
Platform Service throws exception
        ↓
Repository catches it and wraps in Failure
        ↓
Returns Either.left(Failure)
        ↓
Cubit calls result.fold(
  (failure) => emit(UploadProcessFailure(error: failure.message)),
  (results) => emit(UploadProcessSuccess(results)),
)
        ↓
UI displays the error message to the user
```

The `Failure` class (from `core/failure/failure.dart`) typically contains:
- `message` — Human-readable error description
- Possibly `statusCode` — HTTP status code if applicable
- Possibly `stackTrace` — For debugging
