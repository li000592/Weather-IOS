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
git clone https://github.com/li000592/Weather-ios.git

2. Configure API keys:
   - Add your OpenWeather API key to `Secrets.plist`

3. Open and run:
   - Open `WeatherApp.xcodeproj`
   - Select your target device
   - Press `Cmd + R` to build and run

## Configuration

### API Setup
1. Get an API key from [OpenWeather](https://openweathermap.org/api)
2. Create `Secrets.plist` with your API key:

```
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
<key>WEATHER_API_KEY</key>
<string>your_api_key_here</string>
</dict>
</plist>
```

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