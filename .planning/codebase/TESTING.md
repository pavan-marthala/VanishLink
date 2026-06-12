# Testing Guidelines

This document outlines the testing structure, tooling, mock strategies, and execution commands used in the VanishLink codebase.

## 1. Testing Framework and Setup

VanishLink relies on the standard Flutter testing framework:
* **Package**: `flutter_test` (built-in Flutter SDK testing framework).
* **Location**: All tests are located in the root `test/` directory, mirroring the structure of `lib/`.
  - Feature-specific tests are under `test/features/`.
  - Generic/widget tests are under `test/`.

## 2. Mocking Strategy

The project adopts a lightweight and explicit mocking strategy:
* **Fake Classes over Mock Libraries**: Instead of pulling in large external mocking libraries like Mockito or Mocktail, we write custom `Fake` classes implementing repositories or service interfaces (e.g., `FakeCallRepository`, `FakeMessageRepository`, `FakeFirebaseAuth`).
* **Benefits**:
  - **Speed**: Pure Dart classes execute instantly without mock initialization overhead.
  - **Type Safety**: Avoids stringly-typed mock stubs.
  - **Control**: Clean stream controls using `StreamController.broadcast()` allow tests to explicitly emit events and assert behavior step-by-step.
* **GetIt Resetting**: Because many classes fetch singletons from GetIt, tests that register fake singletons must reset GetIt before and after each test run:
  ```dart
  setUp(() {
    GetIt.instance.reset();
    // Register fakes...
  });
  
  tearDown(() {
    GetIt.instance.reset();
  });
  ```

## 3. Test Suites Overview

The codebase is thoroughly tested across key domains:
* **Unit/Bloc Tests**:
  - `call_bloc_test.dart`
  - `message_bloc_test.dart`
  - `presence_bloc_test.dart`
  - `webrtc_bloc_test.dart`
  - `discover_test.dart`
  - `chats_test.dart`
  - `requests_test.dart`
  - `profile_test.dart`
* **Widget/Screen Tests**:
  - `chat_details_screen_test.dart` (asserts message alignment, empty states, and dynamic typing/reaction UI).
  - `discover_screen_test.dart` (asserts search inputs, result listings, and friend request actions).

## 4. Run Commands

* **Run all tests**:
  ```bash
  flutter test
  ```
* **Run a specific test file**:
  ```bash
  flutter test test/features/chat/call_bloc_test.dart
  ```
* **Run tests with coverage**:
  ```bash
  flutter test --coverage
  ```

## 5. Guidelines for Writing Tests

1. **Group Tests**: Always use `group()` blocks describing the target class/bloc (e.g., `group('CallBloc Tests', () { ... })`).
2. **State Transition Assertion**: When asserting Bloc states that rely on stream events or microtasks, use minor delays (e.g., `await Future.delayed(Duration.zero)`) to let asynchronous stream events queue and process.
3. **Resource Cleanup**: In the `tearDown()` block, always close stream controllers in fake repositories and close the Blocs under test to prevent memory leaks.
