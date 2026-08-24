# Taning — Know Your Taning

[![Flutter](https://img.shields.io/badge/Flutter-3.16.0-blue.svg)](https://flutter.dev)
[![Dart](https://img.shields.io/badge/Dart-3.0.0-blue.svg)](https://dart.dev)
[![License](https://img.shields.io/badge/License-MIT-green.svg)](LICENSE)

**Taning** is a beautiful countdown app inspired by the Filipino concept of "taning" — a fixed deadline, time limit, or allotted period. It makes time visible, tangible, and emotionally meaningful.

## 🌟 Features

### Core Features
- **Multiple Countdown Types**: Countdown to a date, duration tracking, count up, and recurring events
- **Beautiful Cards**: Visually rich countdown cards with progress indicators
- **Real-time Updates**: Countdowns update in real-time with smooth animations
- **Customization**: Personalize colors, icons, themes, and countdown styles
- **Notifications**: Get reminders before your important events
- **Home Screen Widgets**: Android and iOS widgets to see your countdown at a glance
- **Dark Mode**: Full dark mode support with proper contrast
- **Accessibility**: Screen reader support, dynamic text, and high contrast

### Countdown Types
| Type | Description | Example |
|------|-------------|---------|
| 📅 Countdown | Count down to a specific date/time | "14 days until vacation" |
| ⏱️ Duration | Track progress through a fixed period | "Day 14 of 30" |
| 📈 Count Up | Count time since a starting date | "14 days since I started" |
| 🔄 Recurring | Events that repeat regularly | "Rent due every month" |

## 📱 Screenshots

| Home Screen | Create Flow | Detail Screen | Widget |
|-------------|-------------|---------------|--------|
| (Screenshot) | (Screenshot) | (Screenshot) | (Screenshot) |

## 🚀 Getting Started

### Prerequisites
- Flutter 3.16.0 or higher
- Dart 3.0.0 or higher
- Android Studio / VS Code with Flutter extensions
- Xcode (for iOS development)
- Android SDK (for Android development)

### Installation

```bash
# Clone the repository
git clone https://github.com/taning-app/taning.git
cd taning

# Install dependencies
flutter pub get

# Generate code
flutter pub run build_runner build --delete-conflicting-outputs

# Run the app
flutter run