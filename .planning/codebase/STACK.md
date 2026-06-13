# Tech Stack

VanishLink is built on the Flutter framework, utilizing Dart for application development. The project leverages cross-platform features to target mobile, web, and desktop environments.

## Dart & Flutter SDK Version

As defined in `pubspec.yaml`:
- **Dart SDK**: `^3.10.4`
- **Flutter SDK**: Implicitly mapped to the corresponding Flutter version (typically Flutter 3.10.x and above matching Dart 3.10.x).

---

## Main Dependencies

### 1. State Management
- **bloc (`^9.2.0`) & flutter_bloc (`^9.1.1`)**: Used to implement the BLoC (Business Logic Component) pattern for unidirectional data flow and state separation.

### 2. Dependency Injection & Service Location
- **get_it (`^9.2.1`)**: A simple service locator for Dart and Flutter.
- **injectable (`^2.4.0`)**: Generator support for `get_it` to automatically assemble dependency registration code.
- **injectable_generator (`^2.4.2`)** (Dev Dependency): Code generation backend for injectable annotations.

### 3. Navigation & Routing
- **go_router (`^17.1.0`)**: Declarative routing system supporting deep linking and shell routes for tab layouts.

### 4. Real-time Communication & Media
- **flutter_webrtc (`^1.4.1`)**: Enables direct Peer-to-Peer audio and video calls.
- **flutter_callkit_incoming (`^3.1.1`)**: Integrates Android ConnectionService and iOS CallKit to show system call screens for incoming WebRTC calls.
- **audioplayers (`^6.7.1`)**: Handles custom in-app ringtones and dialing tones.

### 5. Backend Services (Firebase)
- **firebase_core (`^4.10.0`)**: Initializes Firebase APIs.
- **firebase_auth (`^6.5.2`)**: Authenticates users (email & password).
- **cloud_firestore (`^6.5.0`)**: NoSQL document database for user profiles, friendship requests, and contacts.
- **firebase_database (`^12.4.2`)**: Realtime Database for WebRTC signaling, message exchange with 6-hour expiration, and online presence tracking.
- **firebase_messaging (`any`)**: Push notification delivery.

### 6. Background Services & Local Notifications
- **flutter_background_service (`^5.1.0`)**: Runs background logic.
- **flutter_local_notifications (`^22.0.0`)**: Triggers native notification banners.

### 7. Storage & Security
- **flutter_secure_storage (`^10.0.0`)**: Secure keychain/keystore persistence for sensitive credentials.
- **shared_preferences (`any`)**: Simple key-value storage for settings.
- **no_screenshot (`^1.0.0`)**: Prevents screenshots/screen recordings to enforce privacy.

### 8. Code Generation Utilities
- **freezed_annotation (`^2.4.4`) & freezed (`^2.4.7`)** (Dev Dependency): Code generator for union types, pattern matching, and data classes.
- **json_annotation (`^4.9.0`) & json_serializable (`any`)** (Dev Dependency): Converts model classes to and from JSON.
- **build_runner (`2.4.0`)** (Dev Dependency): Orchestrates the code generation execution pipeline.

### 9. Core Utilities & UI
- **dio (`^5.9.2`) & http**: For HTTP networking.
- **animated_flip_counter (`^0.3.4`)**: Graphic numerical animations.
- **delightful_toast (`^1.1.0`)**: Lightweight, attractive toast alerts.
- **skeletonizer (`^2.1.3`)**: Automatic loading placeholders.
- **flutter_staggered_grid_view (`^0.7.0`)**: Staggered layout.
- **flutter_svg (`^2.2.3`)**: Renders vector graphics.
- **permission_handler (`^12.0.3`)**: Handles run-time permission requests.
- **device_info_plus (`any`) & uuid (`any`)**: Device diagnostics and unique identifier generation.

---

## Target Platforms

VanishLink contains initialization folders and platform-specific configurations for the following targets:

| Platform | Support Status | Key Integrations Used |
| :--- | :--- | :--- |
| **Android** | Fully Supported | Google Play Services, Firebase Cloud Messaging (FCM), Android ConnectionService (via `flutter_callkit_incoming`) |
| **iOS** | Fully Supported | Apple APNS integration, Apple CallKit framework (via `flutter_callkit_incoming`) |
| **Web** | Supported | Service Worker notifications, JS/HTML platform wrappers, Firebase Web Client SDK |
| **macOS** | Native Target | Desktop configurations, standard WebRTC components |
| **Windows** | Native Target | Windows C++ project wrapper |
| **Linux** | Native Target | GTK+ project wrapper |
