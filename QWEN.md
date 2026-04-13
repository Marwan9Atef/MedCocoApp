# QWEN.md



# Section A — General Engineering Rules

## 1) Architecture & Separation of Concerns (YOU MUST FOLLOW)
- Follow the project's architecture layer boundaries strictly: presentation → domain → data
- Never bypass layers or mix responsibilities
- UI/presentation layer has ZERO business logic — only rendering, interaction, and state observation
- Business logic lives in the domain layer
- Data access (APIs, databases, storage) lives in the data layer
- Do not introduce new abstractions or patterns without justification

## 2) Shared Code (IMPORTANT)
- Any reusable logic, utility, constant, extension, or helper used in 2+ places goes in `core/`
- Check `core/` before creating new shared code — never duplicate across features

## 3) Error Handling
- Errors flow cleanly across layers — never skip layers
- Handle null, empty, loading, and error states explicitly — no silent failures
- Catch errors at the boundary (data layer), not deep inside business logic

## 4) Change Discipline
- Make the smallest change that solves the problem
- Fix root causes, not symptoms
- Don't refactor unrelated code unless explicitly requested
- Never break existing functionality, APIs, flows, or UX unless explicitly instructed
- Read relevant code before modifying it — state assumptions when unclear

## 5) Dependencies
- Don't add new packages without justification
- Any new package must be: latest stable, well-maintained, production-grade

## 6) Security
- Never hardcode secrets, tokens, or credentials
- Never log sensitive information
- Validate all external and API input
- Proactively flag security risks when spotted



## 8) Workflow (Mandatory)
- Before marking any task done → run the `/review` skill
- After task approved → commit changes and prepare PR output
- PR descriptions must always be in markdown (`.md`) format

## 9) Parallel Execution & Subagents (IMPORTANT)
- **ALWAYS use subagents** for independent tasks (file search, reading multiple files, analysis) to maximize speed
- **ALWAYS run independent tools in parallel** (e.g., `grep_search` + `glob` + `read_file` together)
- Never run sequential tool calls when they could be parallelized
- Launch agents for open-ended searches requiring multiple rounds — don't do them yourself
- For file writes that don't depend on each other, use subagents to write them concurrently

---

# Section B — Flutter / Dart Specific Rules



## 1) State Management
- Use **Cubit** (from `flutter_bloc`) for feature and application state — not Riverpod, Provider, or GetX
- Cubits depend ONLY on repositories — no use case layer in this project
- `setState` is allowed ONLY for local UI state (e.g., toggles, form focus) — never for business logic
- Keep `setState` scoped to the smallest widget possible to avoid redundant rebuilds up the tree

## 2) Code Generation Policy
- **`injectable_generator` + `build_runner` is allowed** for dependency injection only
- **NO Freezed. NO json_serializable.** Models are hand-written with manual `fromJson`/`toJson`
- Use Dart 3+ native features instead: `sealed class`, `switch` expressions, records

## 3) Domain Layer Purity
- Domain layer must have ZERO Flutter imports
- No `package:flutter/...` in any file under `domain/`

## 4) Feature Folder Structure
```
lib/
├── core/                          # Shared utilities, DI, network, theme, routes, etc.
│   ├── di/                        # get_it + injectable setup
│   ├── network/                   # ApiClient (Dio wrapper)
│   ├── error/                     # AppException hierarchy
│   ├── failure/                   # Failure class
│   ├── theme/                     # AppTheme, AppColors, SizeConfig
│   ├── routes/                    # go_router configuration
│   ├── utils/                     # Validators, snackbars, helpers
│   └── widget/                    # Shared reusable widgets
├── feature/                       # Feature modules (feature-first)
│   └── {feature_name}/
│       ├── data/                  # models, repo impl, services (remote/local)
│       ├── domain/                # repository abstract interfaces
│       └── presentation/          # cubits, screens, widgets
└── view/                          # Main app view/shell
```

## 5) Error Handling Contract
- Data layer: catch `AppException` and map to `Failure` classes
- Domain layer: return `Either<Failure, T>` from repository methods (using `dartz`)
- Presentation layer: Cubit folds `Either` → emits success/failure states with user-friendly messages

## 6) Dependency Injection
- Use **`get_it`** as the service locator with **`injectable`** for code generation
- Register dependencies via `@injectable`, `@LazySingleton`, and `@module` annotations
- Run `dart run build_runner build --delete-conflicting-outputs` after adding/changing DI annotations
- Cubits are resolved via `serviceLocator<CubitType>()` inside `BlocProvider` in route builders
- **NO manual constructor injection** — rely on injectable for all registrations

## 7) Build Method Discipline (IMPORTANT)
- Prefer `const` constructors wherever possible
- NEVER create `TextEditingController`, `AnimationController`, `FocusNode`, or other expensive objects inside `build()`
- Avoid heavy work inside `build()` methods
- Dispose controllers and focus nodes in `StatefulWidget.dispose()`
- Prefer small, composed widgets to minimize rebuild scope
- Use `BlocBuilder`/`BlocSelector` on the smallest widget that needs the state — never at the top of the tree

## 8) Routing
- Use **`go_router`** for all navigation
- Auth routes use `GoRouterGuard` for redirect logic based on auth state
- Each route screen gets its own `BlocProvider` with Cubit from `serviceLocator`
- Use fade transitions for route animations

## 9) Network Layer
- Use the existing `ApiClient` (Dio wrapper) in `core/network/`
- Token interceptor is already configured — don't duplicate auth header logic
- Map Dio errors through `extractDioErrorMessage()` in `app_exception.dart`

---

# Section C — Project-Specific Conventions

## 1) Naming Conventions
- Cubits: `{Feature}Cubit` (e.g., `LoginCubit`, `AuthCubit`)
- States: `{Feature}States` base class, `{Feature}Initial/Loading/Success/Failure`
- Repos: `{Feature}Repo` abstract in domain, `{Feature}RepoImpl` in data
- Services: `{Type}Service` (e.g., `AuthRemoteService`, `AuthLocalService`)
- Models: `{Entity}Model` with manual `fromJson`/`toJson`/`copyWith`

## 2) State Pattern
```dart
abstract class FeatureStates {}
class FeatureInitial extends FeatureStates {}
class FeatureLoading extends FeatureStates {}
class FeatureSuccess extends FeatureStates { final String message; ... }
class FeatureFailure extends FeatureStates { final String error; ... }
```

## 3) Repository Pattern
```dart
// Domain
abstract class FeatureRepo {
  Future<Either<Failure, ResultType>> operation(Params params);
}

// Data
@LazySingleton(as: FeatureRepo)
class FeatureRepoImpl implements FeatureRepo {
  final RemoteService _remote;
  final LocalService _local;
  // ...
}
```

## 4) Cubit Pattern
```dart
@injectable
class FeatureCubit extends Cubit<FeatureStates> {
  final FeatureRepo _repo;
  FeatureCubit(this._repo) : super(FeatureInitial());

  Future<void> action() async {
    emit(FeatureLoading());
    final result = await _repo.operation();
    result.fold(
      (failure) => emit(FeatureFailure(error: failure.message)),
      (success) => emit(FeatureSuccess(message: success.message)),
    );
  }
}
```

## 5) Existing Packages (Don't Duplicate)
- **State mgmt**: `flutter_bloc` (latest stable)
- **DI**: `get_it` (latest stable) + `injectable` (latest stable)
- **HTTP**: `dio` (latest stable)
- **Routing**: `go_router` (latest stable)
- **Functional**: `dartz` (latest stable)
- **Storage**: `shared_preferences`, `flutter_secure_storage` (latest stable)
- **UI**: `flutter_svg`, `photo_view`, `pin_code_fields`, `otp_resend_timer` (latest stable)

> Check `pubspec.yaml` for actual versions. Always use the latest stable compatible with the project's Flutter SDK.
