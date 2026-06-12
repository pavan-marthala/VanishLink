# Structure Documentation

This document describes the directory layout and explain the boundaries between layers (domain, data, and presentation) within the VanishLink codebase.

---

## 1. Directory Structure

The project follows a modular, feature-oriented structure inside the `lib/` directory:

```
lib/
├── core/                         # Shared core architecture
│   ├── di/                       # Dependency injection setup (GetIt)
│   ├── routes/                   # Routing configuration
│   ├── theme/                    # Colors, gradients, typography, app themes
│   ├── utils/                    # Common utilities & extensions
│   └── widgets/                  # Reusable UI widgets used across features
│
└── features/                     # Feature modules
    ├── auth/                     # Authentication feature
    ├── chat/                     # Real-time Chat, Presence, WebRTC, Calling
    ├── discover/                 # Search and discover user profiles
    ├── home/                     # Simple Dashboard/Landing view
    ├── profile/                  # User profile and account configurations
    └── request/                  # Friend request management
```

For each feature under `features/`, code is segregated into layers representing **Clean Architecture** boundaries:

```
features/<feature_name>/
├── data/                         # Data Layer
│   ├── datasource/               # External APIs / Firebase providers
│   ├── models/                   # Serialization classes (Freezed/JSON)
│   └── repositories/             # Concrete Repository implementations
│
├── domain/                       # Domain Layer
│   ├── entities/                 # Pure domain business data models
│   ├── repositories/             # Abstract Repository interfaces
│   └── services/                 # Complex business flow orchestrators
│
└── presentation/                 # Presentation Layer
    ├── bloc/                     # State management components (Bloc/Event/State)
    ├── screens/                  # Top-level scaffold pages
    └── widgets/                  # Feature-specific layout widgets
```

---

## 2. Layer Boundaries & Splits

To maintain clean codebase separation, the dependencies flow in one direction: **Presentation and Data layers depend on the Domain layer, but the Domain layer is completely independent.**

### A. Domain Layer (Core Business Logic)
The domain layer represents the absolute center of the feature. It contains:
- **Entities**: Simple Dart structures defining business objects (e.g., `CallModel`, `UserProfile`, `AuthUser`, `PresenceStatus`). They are independent of database frameworks or JSON serialization hooks.
- **Repositories**: Abstract contracts specifying what actions can be executed on data. By keeping them abstract, the domain layer does not care where the data comes from (e.g. Firestore vs local memory).
- **Services/Use Cases**: High-level orchestrators coordinating multiple entities or complex operational patterns. For example, `CallCoordinator` orchestrates permissions, ringtones, system notifications, and connection states.

### B. Data Layer (Data & Serialization)
The data layer is responsible for translating remote sources (Firebase RTDB, Firestore, Device APIs) into domain models. It contains:
- **DataSources**: Handles raw network configurations and Firebase database references.
- **Models**: Extends or maps to Domain Entities, adding deserialization/serialization capabilities (e.g., `FirestoreUserModel` maps Firebase documents to `AuthUser`). These models use `freezed` and `json_serializable` packages.
- **Repository Implementations**: Implement the abstract definitions declared in the Domain layer. They fetch data via DataSources or Firebase client SDKs, convert raw database documents/objects into entities, and return them back to the Domain layer.

### C. Presentation Layer (UI & States)
The presentation layer is responsible for displaying data and handling user inputs. It contains:
- **Bloc / Cubit**: Business Logic Components that listen to UI events, process them using repositories/services from the Domain layer, and yield UI states.
- **Screens**: Full-page views loaded by the router (e.g., `ChatScreen`, `CallScreen`).
- **Widgets**: Sub-components of screens that can be reused within the feature.

---

## 3. Dependency Injection (DI)

Dependencies between layers are resolved using the **`get_it`** package configured in `lib/core/di/injection.dart`.
- Repositories are registered against their interfaces (e.g. registering `PresenceRepositoryImpl` for `PresenceRepository`).
- Services and Blocs are registered as singletons or factories depending on their lifecycle state requirements.
- Injection ensures that layer components do not manually instantiate their dependencies, preserving mockability for unit testing.
