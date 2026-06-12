# Codebase Conventions

This document outlines the coding standards, patterns, and conventions used in the VanishLink codebase.

## 1. Directory Structure and Architectural Split

VanishLink is built using Clean Architecture concepts. The codebase is modular and structured by feature inside the `lib/features/` folder.

Each feature folder is divided into three layers:
1. **Domain Layer**:
   - Contains pure business logic and contracts (interfaces).
   - **Entities**: Business models (`auth_user.dart`, `presence_status.dart`).
   - **Repositories**: Abstract contracts (`auth_repository.dart`, `chat_repository.dart`).
   - **Services**: Pure logic orchestration (`presence_service.dart`, `webrtc_service.dart`).
   - Free of dependencies on external packages, UI frameworks, or specific databases.
2. **Data Layer**:
   - Contains concrete implementations of the domain contracts.
   - **Models**: Freezed data models with JSON serialization support (`contact_model.dart`).
   - **Datasources**: Remote or local data sources (`auth_remote_data_source.dart`).
   - **Repositories**: Implementations of domain repository interfaces (`auth_repository_impl.dart`).
3. **Presentation Layer**:
   - Contains everything related to the user interface.
   - **Bloc**: State management files (`auth_bloc.dart`).
   - **Screens**: Complete pages/routes (`chat_details_screen.dart`).
   - **Widgets**: Reusable components specific to that feature.

## 2. Naming Conventions

* **Files & Directories**: Use `snake_case` (e.g., `auth_remote_data_source.dart`, `chat_details_screen.dart`).
* **Classes**: Use `PascalCase` (e.g., `AuthRepositoryImpl`, `ChatDetailsScreen`).
* **Variables & Methods**: Use `camelCase` (e.g., `currentUser`, `updateCallStatus`).
* **Private Members**: Prefix private class fields and methods with an underscore (e.g., `_authRepository`, `_authStateSubscription`).
* **Part Files**: When code is generated (e.g., Freezed or JSON Serializable), keep generated files as part files (e.g., `part 'auth_bloc.freezed.dart';`).

## 3. State Management

The project uses `flutter_bloc` for state management, combined with `freezed` for type-safe states and events:
* **Union Types**: All Bloc Events and States use Freezed unions.
* **Map / Pattern Matching**: Events are handled in Blocs using `event.map` or `event.maybeMap` to enforce exhaustive handling of all defined events.
* **Bloc Initialization**: Blocs are registered as Factory instances in dependency injection (recreated on every page load to clean up state).
* **Subscriptions**: Any stream subscription inside a Bloc must be closed in the overridden `close()` method of the Bloc.

Example event handling template:
```dart
on<AuthEvent>((event, emit) async {
  await event.map(
    started: (e) async { /* ... */ },
    authStateChanged: (e) async { /* ... */ },
    signOutRequested: (e) async { /* ... */ },
  );
});
```

## 4. Dependency Injection

VanishLink uses `get_it` for dependency injection:
* **Manual Configuration**: All dependencies are manually registered inside `lib/core/di/injection.dart` in the `configureDependencies()` function.
* **Dependency Lifetimes**:
  - **Lazy Singletons (`registerLazySingleton`)**: Used for repositories, services, external clients (like `FirebaseAuth`), and shared coordinators (like `CallCoordinator`).
  - **Factories (`registerFactory`)**: Used for Blocs so that a fresh instance is constructed whenever a UI view is pushed or rebuilt.
* **Interface Binding**: Always register the implementation class typed against the domain repository interface:
  ```dart
  getIt.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(getIt<AuthRemoteDataSource>()),
  );
  ```
