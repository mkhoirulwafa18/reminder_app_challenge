# Reminder App Challenge

---

## 📱 Screenshots

<div align="center">
<div>
<img src="screenshots\1.png" width="25%" />
<img src="screenshots\7.png" width="25%" />
<img src="screenshots\2.png" width="25%" />
<img src="screenshots\3.png" width="25%" />
<img src="screenshots\4.png" width="25%" />

<img src="screenshots\8.png" width="25%" />

</div>
</div>

<br>

## 📜 ⬇️ Installation Guide

This handy table lists all the methods you can use to install Reminder App Challenge:

<table>
  <tr>
    <th>Platform</th>
    <th>Package/Installation Method</th>
  </tr>
  <tr>
    <td>Android</td>
    <td>
      <a href="https://drive.google.com/file/d/1xzh54VK9VOP3u-gqXGsFvlRzpDy-BNQg/view?usp=sharing">
        Google Drive
      </a>
    </td>
  </tr>
</table>

## 🕳️ Building from Source

You can compile the Reminder App Challenge's source code by doing the following:

1. Download the latest Flutter SDK (mine is >=3.19.0)
2. Clone the Repo
3. Now run the following to bootstrap the project:
   ```bash
   flutter pub get && dart run build_runner build --delete-conflicting-outputs
   ```
4. Finally, run the following commands in the root of the project to start the Reminder App Challenge locally:
   ```bash
   flutter run <android-device-id>
   ```

## Tech Specification

- Programming Language: Dart
- State Management: BLoC
- Environment:
  - Flutter version: 3.19.2
  - Dart Version: 3.3.0

## Architecture

The app follows the Clean Architecture pattern, separating concerns into three main layers:

1. **Presentation Layer**: Responsible for UI and user interactions. Implemented using Flutter widgets.
2. **Domain Layer**: Contains business logic and use cases. It is independent of any UI framework.
3. **Data Layer**: Handles data retrieval and manipulation. Communicates with external sources such as APIs and local storage.

## Project Structure Overview

This section outlines the high-level structure of the Reminder App Challenge project, detailing key directories and their purposes:

- `assets/`: Static assets like images, icons, and fonts.

- `lib/`: Main source directory for Flutter.
  - `core/`: Houses the fundamental business logic and utility functions.
  - `data/`: Contains data layer components such as repositories and models.
  - `domain/`: Defines use cases and domain logic.
  - `presentation/`: Holds UI components and BLoCs for various features.

## Dependencies

1. [Bloc](https://pub.dev/packages/bloc) - A predictable state management library.
2. [Equatable](https://pub.dev/packages/equatable) - A package to simplify equality comparisons.
3. [Flutter](https://flutter.dev) - Flutter is an open-source UI software development toolkit created by Google.
4. [Flutter Bloc](https://pub.dev/packages/flutter_bloc) - Flutter widgets that make it easy to integrate blocs and cubits.
5. [Flutter Local Notifications](https://pub.dev/packages/flutter_local_notifications) - A cross-platform plugin for displaying local notifications.
6. [Flutter Slidable](https://pub.dev/packages/flutter_slidable) - A Flutter implementation of slidable list item.
7. [Flutter Timezone](https://pub.dev/packages/flutter_timezone) - A plugin to get the local timezone.
8. [Geolocator](https://pub.dev/packages/geolocator) - A Flutter geolocation plugin for Android and iOS.
9. [Get It](https://pub.dev/packages/get_it) - Simple direct service locator for Dart and Flutter projects.
10. [Google Fonts](https://pub.dev/packages/google_fonts) - A Flutter package to use Google Fonts in your app.
11. [Hive](https://pub.dev/packages/hive) - A lightweight and fast key-value database written in pure Dart.
12. [Hive Flutter](https://pub.dev/packages/hive_flutter) - Flutter integration for Hive.
13. [Notification Permissions](https://pub.dev/packages/notification_permissions) - A package for checking and requesting notification permissions.
14. [Path Provider](https://pub.dev/packages/path_provider) - A Flutter plugin for finding commonly used locations on the filesystem.

## Dev Dependencies

1. [Build Runner](https://pub.dev/packages/build_runner) - A build system for Dart code generation and modular compilation.
2. [Flutter Lints](https://pub.dev/packages/flutter_lints) - Lint rules for Flutter apps, packages, and plugins to encourage good coding practices.
3. [Flutter Test](https://pub.dev/packages/flutter_test) - A Flutter package for testing Flutter apps.
4. [Hive Generator](https://pub.dev/packages/hive_generator) - Automatically generate TypeAdapters for your Hive types.

---
