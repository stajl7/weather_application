# Weather Application

A Flutter weather application that displays current weather conditions, a multi-day forecast, and additional weather information in a clean and visual interface.

The project was originally developed as a mobile application and later restored and updated to work with a modern Flutter and Dart environment.

## Overview

The application allows users to view weather information for a selected location, including temperature, weather conditions, humidity, wind speed, visibility, and sunrise/sunset times.

It also includes location search and favorite locations stored locally on the device.

The original version of the project used the OpenWeather API. Since the original OpenWeather One Call 2.5 endpoint was discontinued, the repository now includes a Demo Mode with bundled weather data so the application can be launched without requiring access to a paid or legacy API.

## Features

- Current weather conditions
- Current temperature
- Minimum and maximum temperature
- Multi-day weather forecast
- Weather condition icons
- Wind speed
- Humidity
- Visibility
- Sunrise and sunset information
- Location search
- Favorite locations
- Local data persistence
- Dynamic weather backgrounds
- Demo mode with bundled weather data
- Optional OpenWeather API integration

## Technologies

The project is built with:

- Flutter
- Dart
- Provider for state management
- Hive for local storage
- Shared Preferences
- flutter_svg
- flutter_dotenv
- OpenWeather API
- JSON serialization and parsing

## Project Structure

```text
lib/
├── domain/
│   ├── api/
│   ├── hive/
│   ├── json_convertors/
│   └── provider/
│
└── ui/
    ├── components/
    ├── constants/
    ├── pages/
    ├── resources/
    ├── routes/
    └── ui_theme/

assets/
├── demo/
├── fonts/
├── icons/
└── images/
```

The project separates data handling and business logic from the user interface.

- `domain/api` contains API and weather data loading logic.
- `domain/json_convertors` contains models used to convert JSON responses into Dart objects.
- `domain/provider` contains application state and weather-related logic.
- `domain/hive` handles local storage.
- `ui/components` contains reusable UI components.
- `ui/pages` contains application screens.
- `ui/routes` contains navigation logic.
- `ui/ui_theme` contains application colors and styles.

## Demo Mode

The application runs in Demo Mode by default.

Demo weather data is stored locally in:

```text
assets/demo/
├── coord.json
└── weather_data.json
```

This makes the project reproducible and allows anyone to explore the application without creating an account with an external weather provider.

When Demo Mode is enabled, the application uses the bundled JSON data instead of making external API requests.

## Live Weather Integration

The original application used OpenWeather for live weather information.

The project still contains support for live API requests. An OpenWeather API key can be stored in a local `.env` file:

```env
API_KEY=YOUR_API_KEY
```

The real `.env` file is excluded from Git for security reasons.

A template is provided:

```text
.env.example
```

To create the local environment file:

```bash
cp .env.example .env
```

> Note: the original project used OpenWeather One Call API 2.5. That API version was later discontinued. Demo Mode is therefore enabled by default so the project remains fully viewable without relying on the legacy external service.

## Getting Started

### 1. Clone the repository

```bash
git clone https://github.com/YOUR_USERNAME/weather-application.git
cd weather-application
```

### 2. Install dependencies

```bash
flutter pub get
```

### 3. Create the environment file

```bash
cp .env.example .env
```

For Demo Mode, the API key can remain empty.

### 4. Run the application

```bash
flutter run
```

For macOS:

```bash
flutter run -d macos
```

## Screenshots

### Home Screen

_Add screenshot here_

### Weather Forecast

_Add screenshot here_

### Location Search

_Add screenshot here_

## Development History

This application was originally developed several years ago using an older Flutter/Dart environment.

The project was later restored and modernized to work with current Flutter and Dart versions. The restoration included:

- updating Flutter dependencies;
- migrating the project to a modern Dart SDK;
- restoring package imports;
- updating deprecated Flutter code;
- restoring macOS build support;
- updating platform permissions;
- securing API credentials using environment variables;
- replacing the discontinued weather API dependency with a demo-data fallback;
- improving compatibility with modern Flutter layouts.

The original architecture and application logic were preserved wherever possible.

## Security

API credentials are never committed to the repository.

The following file is excluded through `.gitignore`:

```text
.env
```

Only `.env.example`, which contains no real credentials, is included in the repository.

## Future Improvements

Possible future improvements include:

- integration with a new live weather API;
- automatic location detection;
- additional localization support;
- improved responsive layouts for desktop and mobile;
- unit and widget tests;
- improved error handling and offline support.

## Author

Developed as a Flutter weather application project.
