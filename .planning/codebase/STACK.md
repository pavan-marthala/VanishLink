# Technical Stack - VanishLink

This document details the programming languages, SDKs, frameworks, key packages, and target platform configurations of the VanishLink codebase.

## 1. Core SDK & Frameworks
- **Language**: Dart (SDK constraint: `^3.10.4`)
- **Framework**: Flutter (configured with Material Design: `uses-material-design: true`)

## 2. Key Dependencies (`pubspec.yaml`)

### State Management
- `bloc` (^9.2.0): Core BLoC library.
- `flutter_bloc` (^9.1.1): Flutter widgets to integrate BLoC architectures.

### Navigation & Routing
- `go_router` (^17.1.0): Declarative routing pattern with nested shell navigator configurations.

### Realtime Communication & Calling
- `flutter_webrtc` (^1.4.1): Native WebRTC wrapper for audio/video stream routing.
- `flutter_callkit_incoming` (^3.1.1): Handles OS-level call UI screen hooks (Android/iOS).
- `flutter_local_notifications` (^22.0.0): Local notifications trigger for calls & system cues.
- `permission_handler` (^12.0.3): Dynamic run-time permissions (Microphone & Camera).

### Backend Infrastructure (Firebase)
- `firebase_core` (^4.10.0): Firebase client initializer.
- `firebase_auth` (^6.5.2): Authentication and token handling.
- `cloud_firestore` (^6.5.0): Persistent database for user records & call history.
- `firebase_database` (^12.4.2): Low-latency Realtime Database for presence sync and call signaling.

### Dependency Injection
- `get_it` (^9.2.1): Dependency lookup register.
- `injectable` (^2.4.0): Code generator companion for GetIt registers.

### Media & Assets
- `audioplayers` (^6.7.1): Ringtone/dial-tone audio loop players.
- `flutter_svg` (^2.2.3): Vector asset rendering.

### Storage & Network APIs
- `dio` (^5.9.2): High-level HTTP client library.
- `shared_preferences` & `flutter_secure_storage` (^10.0.0): Preferences configuration and key-value secure storage.

### UI & Styling Helpers
- `skeletonizer` (^2.1.3): Skeleton load states.
- `delightful_toast` (^1.1.0): Interactive alerts/toasts.
- `animated_flip_counter` (^0.3.4): Animated value changes.
- `flutter_staggered_grid_view` (^0.7.0): Grid patterns.

### Development & Generators
- `build_runner` (2.4.0): Generator execution orchestration.
- `freezed` (^2.4.7) & `freezed_annotation` (^2.4.4): Immutable data models and union mapping generator.
- `injectable_generator` (^2.4.2): Injection helper logic builder.
- `json_serializable` & `json_annotation` (^4.9.0): Automatic JSON parsing serialization.

---

## 3. Platform Support & Constraints
- **Android**: Supported through native configurations (`android` directory, custom service binds, local notifications channel).
- **iOS**: Supported (`ios` directory, custom Darwin initialization parameters, CallKit wrapper mappings).
- **Web**: Fallback support (`web` directory, custom overlays for calls & presence instead of CallKit, conditional layouts for web database/WebRTC wrappers).
- **Desktop/Desktop-Platforms**: Core project roots define folders for `linux`, `macos`, `windows` with overlay management fallback drivers.
