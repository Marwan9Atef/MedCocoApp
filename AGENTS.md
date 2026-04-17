# AGENTS.md

This file defines the default working rules for AI coding agents operating in this repository.

Priority note:
- Treat this file and `.cursor/rules/cursor-local-rules.mdc` as aligned sources of truth.
- If they ever diverge, prefer the stricter rule unless the user explicitly says otherwise.

## General Engineering Rules

### Architecture & Separation of Concerns
- Follow the project's architecture layer boundaries strictly: `presentation -> domain -> data`
- Never bypass layers or mix responsibilities
- UI/presentation layer has zero business logic; it is only for rendering, interaction, and state observation
- Business logic lives in the domain layer
- Data access (APIs, databases, storage) lives in the data layer
- Do not introduce new abstractions or patterns without justification

### Shared Code
- Any reusable logic, utility, constant, extension, or helper used in 2+ places goes in `core/`
- Check `core/` before creating new shared code
- Never duplicate shared logic across features

### Error Handling
- Errors must flow cleanly across layers; never skip layers
- Handle null, empty, loading, and error states explicitly
- Avoid silent failures
- Catch errors at the boundary (data layer), not deep inside business logic

### Change Discipline
- Make the smallest change that solves the problem
- Fix root causes, not symptoms
- Do not refactor unrelated code unless explicitly requested
- Never break existing functionality, APIs, flows, or UX unless explicitly instructed
- Read relevant code before modifying it and state assumptions when unclear

### Dependencies
- Do not add new packages without justification
- Any new package must be latest stable, well-maintained, and production-grade

### Security
- Never hardcode secrets, tokens, or credentials
- Never log sensitive information
- Validate all external and API input
- Proactively flag security risks when spotted
- Do not read any `.env` files, including `.env` and `.env.*`, unless the user explicitly asks

### Workflow
- Before marking a task done, perform a review pass focused on regressions, architecture compliance, and missing tests
- After task approval, commit changes and prepare PR output when requested
- PR descriptions must be in markdown (`.md`) format

### Execution Style
- Run independent searches, reads, and analysis in parallel when possible
- Prefer fast repository search tools such as `rg`
- Keep changes minimal and local unless broader edits are necessary

## Flutter / Dart Rules

### State Management
- Use Cubit from `flutter_bloc` for feature and application state
- Do not introduce Riverpod, Provider, or GetX
- Cubits depend only on repositories; no use case layer in this project
- `setState` is allowed only for local UI state such as toggles and focus
- Keep `setState` scoped to the smallest widget possible

### Code Generation Policy
- `injectable_generator` and `build_runner` are allowed for dependency injection only
- Do not use Freezed
- Do not use `json_serializable`
- Models should be hand-written with manual `fromJson` and `toJson`
- Prefer Dart 3+ native features such as `sealed class`, `switch` expressions, and records

### Domain Layer Purity
- Domain layer must have zero Flutter imports
- No `package:flutter/...` imports in files under `domain/`

### Feature Folder Structure
```text
lib/
|-- core/                          # Shared utilities, DI, network, theme, routes, etc.
|   |-- di/                        # get_it + injectable setup
|   |-- network/                   # ApiClient (Dio wrapper)
|   |-- error/                     # AppException hierarchy
|   |-- failure/                   # Failure class
|   |-- theme/                     # AppTheme, AppColors, SizeConfig
|   |-- routes/                    # go_router configuration
|   |-- utils/                     # Validators, snackbars, helpers
|   `-- widget/                    # Shared reusable widgets
|-- feature/                       # Feature modules (feature-first)
|   `-- {feature_name}/
|       |-- data/                  # models, repo impl, services (remote/local)
|       |-- domain/                # repository abstract interfaces
|       `-- presentation/          # cubits, screens, widgets
`-- view/                          # Main app view/shell
```

### Error Handling Contract
- Data layer catches `AppException` and maps to `Failure`
- Domain layer returns `Either<Failure, T>` from repository methods using `dartz`
- Presentation layer Cubits fold `Either` and emit success/failure states with user-friendly messages

### Dependency Injection
- Use `get_it` as service locator with `injectable` for code generation
- Register dependencies via `@injectable`, `@LazySingleton`, and `@module`
- Run `dart run build_runner build --delete-conflicting-outputs` after adding or changing DI annotations
- Resolve Cubits via `serviceLocator<CubitType>()` inside `BlocProvider` in route builders
- Do not switch to manual constructor injection for registrations

### Build Method Discipline
- Prefer `const` constructors wherever possible
- Never create `TextEditingController`, `AnimationController`, `FocusNode`, or similar expensive objects inside `build()`
- Avoid heavy work inside `build()`
- Dispose controllers and focus nodes in `StatefulWidget.dispose()`
- Prefer small, composed widgets to minimize rebuild scope
- Use `BlocBuilder` and `BlocSelector` on the smallest widget that needs the state

### Routing
- Use `go_router` for all navigation
- Auth routes use `GoRouterGuard` for redirect logic based on auth state
- Each route screen gets its own `BlocProvider` with Cubit from `serviceLocator`
- Use fade transitions for route animations

### Network Layer
- Use the existing `ApiClient` in `core/network/`
- Token interceptor is already configured; do not duplicate auth header logic
- Map Dio errors through `extractDioErrorMessage()` in `app_exception.dart`

## Project-Specific Conventions

### Naming Conventions
- Cubits: `{Feature}Cubit`
- States: `{Feature}States` base class, plus `{Feature}Initial`, `{Feature}Loading`, `{Feature}Success`, `{Feature}Failure`
- Repositories: `{Feature}Repo` in domain and `{Feature}RepoImpl` in data
- Services: `{Type}Service`
- Models: `{Entity}Model` with manual `fromJson`, `toJson`, and `copyWith`

### State Pattern
```dart
abstract class FeatureStates {}
class FeatureInitial extends FeatureStates {}
class FeatureLoading extends FeatureStates {}
class FeatureSuccess extends FeatureStates { final String message; }
class FeatureFailure extends FeatureStates { final String error; }
```

### Repository Pattern
```dart
abstract class FeatureRepo {
  Future<Either<Failure, ResultType>> operation(Params params);
}

@LazySingleton(as: FeatureRepo)
class FeatureRepoImpl implements FeatureRepo {
  final RemoteService _remote;
  final LocalService _local;
}
```

### Cubit Pattern
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

### Existing Packages
- State management: `flutter_bloc`
- DI: `get_it`, `injectable`
- HTTP: `dio`
- Routing: `go_router`
- Functional: `dartz`
- Storage: `shared_preferences`, `flutter_secure_storage`
- UI: `flutter_svg`, `photo_view`, `pin_code_fields`, `otp_resend_timer`

Check `pubspec.yaml` for exact versions and keep compatibility with the project's Flutter SDK.
