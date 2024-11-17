# Weather App

A modern iOS weather application that provides real-time weather information with a clean, intuitive interface built using SwiftUI.

## Features

- 🌤 Real-time weather information
- 📍 Location-based weather updates
- 🔍 Search any city worldwide
- 🎨 Modern SwiftUI interface
- 🔄 Auto-refresh weather data
- 📱 Native iOS design

## Requirements

- iOS 15.0+
- Xcode 14.0+
- Swift 5.5+

## Installation

1. Clone the repository:
bash
git clone https://github.com/yourusername/WeatherApp.git

2. Configure API keys:
   - Rename `Secrets.example.plist` to `Secrets.plist`
   - Add your OpenWeather API key to `Secrets.plist`

3. Open and run:
   - Open `WeatherApp.xcodeproj`
   - Select your target device
   - Press `Cmd + R` to build and run

## Project Structure

```
WeatherApp/
├── App/
│   └── WeatherApp.swift          # App entry point
├── Views/
│   ├── ContentView.swift         # Main view
│   └── SearchBarView.swift       # Search functionality
├── Models/
│   └── WeatherModel.swift        # Data models
└── Resources/
    ├── Assets.xcassets          # Images and colors
    └── Secrets.plist           # API configuration
```

## Privacy

This app requires:
- Location access for local weather
- Internet connection for weather data

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

---

<p align="center">
  Made with ❤️ by Haorong
</p>