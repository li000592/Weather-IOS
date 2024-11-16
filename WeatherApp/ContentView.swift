//
//  ContentView.swift
//  WeatherApp
//
//  Created by Haorong Li on 2024-11-16.
//
//
//  ContentView.swift
//  WeatherApp
//

import SwiftUI
import CoreLocation

struct ContentView: View {
    @State private var city: String = ""
    @State private var weather: WeatherResponse?
    @StateObject private var locationManager = LocationManager() // Add LocationManager instance
    private let weatherService = WeatherService()

    var body: some View {
        VStack(spacing: 0) {
            GeometryReader { geometry in
                VStack(spacing: 0) {
                    // Header View at the top
                    HeaderView()
                        .frame(maxWidth: .infinity)
                        .background(Color(hex: "#00d1b2"))
                        .padding(.top, geometry.safeAreaInsets.top) // Respect safe area insets on top
                        .edgesIgnoringSafeArea([.top, .horizontal]) // Ensures no bottom padding influence, only edges at the top and horizontally

                    // Directly below the header without any spacing
                    SearchBarView(
                        city: $city,
                        onSearch: fetchWeather,
                        onFetchCurrentLocation: fetchCurrentLocationWeather // Added this closure
                    )

                    // Main content for displaying weather information
                    if let weather = weather {
                        VStack {
                            Text("Weather in \(weather.name)")
                                .font(.title)
                                .padding()

                            Text("Temperature: \(weather.main.temp, specifier: "%.1f")°C")
                                .font(.largeTitle)
                                .padding()
                        }
                        .padding(.horizontal)
                    }

                    Spacer() // Pushes remaining content down to fill available space
                }
                .frame(width: geometry.size.width, height: geometry.size.height)
            }
        }
    }

    private func fetchWeather() {
        weatherService.fetchWeather(city: city) { response in
            self.weather = response
        }
    }

    private func fetchCurrentLocationWeather() {
        locationManager.requestLocation() // Request current location
        if let location = locationManager.location {
            let latitude = location.coordinate.latitude
            let longitude = location.coordinate.longitude
            weatherService.fetchWeatherByCoordinates(latitude: latitude, longitude: longitude) { response in
                self.weather = response
            }
        } else {
            print("Location not available")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
