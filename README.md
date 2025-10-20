# Clima App 🌤️

Clima App is a modern **weather application** built with **Flutter**. It provides real-time weather updates for any city or the user’s current location with a clean and intuitive interface.

---

## Features

- 🌎 Get weather information by **city name** or **current location**
- 🌡️ Display temperature, humidity, wind speed, and weather condition
- ☀️ Dynamic UI that changes based on weather conditions
- 🔄 Smooth transitions and loading screens
- ⚡ Lightweight and fast

![Example Screenshot](assets/images/screenshot.png)  <!-- Replace with your screenshot -->

---

## Installation

1. Make sure you have **Flutter** installed: [Flutter installation guide](https://flutter.dev/docs/get-started/install)
2. Clone the repository:

```bash
git clone https://github.com/Adam2318/clima_app.git
cd clima_app
```
Install dependencies:
```bash
flutter pub get
```

Run the app:
```bash
flutter run
```

Project Structure
```bash
lib/
├─ main.dart                  # Entry point
├─ screens/
│  ├─ city_screen.dart        # Screen to enter city name
│  ├─ loading_screen.dart     # Splash/loading screen
│  └─ location_screen.dart    # Main weather screen
├─ services/
│  ├─ location_service.dart   # Get device location
│  ├─ networking_service.dart # API requests
│  └─ weather_model.dart      # Weather data model
├─ utilities/
│  └─ constants.dart          # App constants
└─ widgets/
   └─ weather_detail.dart     # Custom widgets for weather display
```

API

Clima App uses the OpenWeatherMap API. Make sure to create a `.env` file in the root folder and put your API key like this:

API_KEY=YOUR_API_KEY


🌤️ Have fun checking the weather! 😄
