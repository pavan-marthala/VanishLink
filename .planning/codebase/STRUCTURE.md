# Structure of VanishLink Codebase

This document maps out the directory layout of the **VanishLink** Flutter codebase and explains the strict boundary definitions between layers.

---

## 1. Directory Layout

The core of the codebase is inside the `lib/` directory, partitioned into `core/` (shared infrastructure) and `features/` (feature-sliced directories).

```
lib/
├── core/                           # Shared modules across multiple features
│   ├── di/                         # Dependency injection setup (get_it)
│   ├── routes/                     # Application routing definitions
│   ├── services/                   # App-wide utility services (e.g. PermissionManager)
│   ├── theme/                      # Styling definitions (Colors, Typography, Themes)
│   ├── utils/                      # Helper extension classes & helper methods
│   └── widgets/                    # Shared UI components (inputs, loading indicators, skeletons)
│
├── features/                       # Feature-sliced folders
│   ├── auth/                       # User authentication & registration
│   ├── chat/                       # Main chat messaging, real-time presence, WebRTC calls
│   ├── discover/                   # User matching and search
│   ├── home/                       # App shell and root navigation structure
│   ├── profile/                    # User profile view & settings
│   └── request/                    # Friend requests and match invitation management
│
├── firebase_options.dart           # Auto-generated Firebase settings
└── main.dart                       # App entry point
```

---

## 2. Feature Directory Boundaries

Within each feature folder (e.g., `lib/features/chat/`), the folder structure enforces Clean Architecture boundaries:

```
lib/features/chat/
├── data/                           # Data Layer
│   ├── datasource/                 # Remote (Firebase) and Local datasources
│   ├── models/                     # Data models (JSON serializers, extensions of entities)
│   └── repositories/               # Concrete repository implementations
│
├── domain/                         # Domain Layer (Pure Dart)
│   ├── entities/                   # Business logic entities (immutable objects)
│   ├── repositories/               # Abstract repository contracts
│   └── services/                   # High-level domain managers (CallCoordinator, etc.)
│
└── presentation/                   # Presentation Layer (Flutter dependent)
    ├── bloc/                       # State management logic
    ├── screens/                    # Full screen widgets
    └── widgets/                    # Local helper widgets specific to the feature
```

---

## 3. Boundary Rules & Dependencies

To ensure a robust, maintainable codebase, developers must respect the dependency direction rules:

1. **Domain Layer (Pure Dart):**
   - **No external framework imports:** It must not import `flutter/widgets.dart` (except for UI coordinate services if absolutely necessary), `cloud_firestore`, or `firebase_database`.
   - **No data-layer references:** It should never import from `data/` directory or instantiate concrete repository classes directly (use get_it DI interfaces).
   
2. **Data Layer (Infrastructure):**
   - **Depends on Domain:** Implements repository contracts defined in the Domain layer.
   - **Translates Models to Entities:** Uses Data Models (usually auto-generated with `freezed` and `json_serializable`) and maps them to clean Domain Entities before returning data to the Domain layer.
   
3. **Presentation Layer (UI & State):**
   - **No direct database queries:** The UI and BLoC components must only communicate with Domain repositories or Domain services. They should never invoke direct Firestore / RTDB references.
   - **Dependency Injection:** Resolves repositories and services through `getIt` (defined in `lib/core/di/injection.dart`).
