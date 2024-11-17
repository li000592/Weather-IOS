//
//  ContentView.swift
//  WeatherApp
//

import SwiftUI

struct ContentView: View {
    @State private var city: String = "" // User input for city
    @State private var weather: WeatherResponse?
    @State private var errorMessage: String? // Holds error messages for display
    @StateObject private var locationManager = LocationManager() // Instance of LocationManager
    @State private var isLoading: Bool = false // State to track loading status
    private let weatherService = WeatherService()

    var body: some View {
        VStack(spacing: 0) {
            GeometryReader { geometry in
                VStack(spacing: 0) {
                    HeaderView()
                        .frame(maxWidth: .infinity)
                        .background(Color(hex: "#00d1b2"))

                    SearchBarView(
                        city: $city,
                        onSearch: fetchWeather,
                        onFetchCurrentLocation: handleCurrentLocation,
                        errorMessage: errorMessage
                    )
                    .padding(.top, 8)

                    if isLoading {
                        ProgressView("Loading...") // Show loading indicator
                            .padding()
                    } else if let weather = weather {
                        WeatherInfoView(weather: weather)
                    } else if let errorMessage = errorMessage {
                        Text(errorMessage)
                            .foregroundColor(.red)
                            .padding()
                    } else {
                        Text("Enter a city to see weather data.")
                            .foregroundColor(.gray)
                            .padding()
                    }
                }
                .frame(width: geometry.size.width, height: geometry.size.height)
                .onAppear {
                    fetchWeather()
                    let weatherService = WeatherService()
                    weatherService.fetchHourlyWeather(city: "London") { response in
                        if let response = response {
                            // Handle hourly weather data
                            print(response)
                        } else {
                            print("Failed to fetch hourly weather data.")
                        }
                    }
                }
            }
        }
//        GoogleAdView()
//            .frame(height: 50)
    }

    // Fetch weather by city name
    private func fetchWeather() {
        errorMessage = nil // Clear previous errors

        // Use default city if input is empty or only contains whitespace
        let queryCity = city.trimmingCharacters(in: .whitespaces).isEmpty ? "Ottawa" : city
        
        weatherService.fetchWeather(city: queryCity) { response in
            DispatchQueue.main.async {
                if let weatherResponse = response {
                    dump(weatherResponse) // This prints the entire object with its structure
                } else {
                    print("Failed to fetch weather data.")
                }
                if let response = response {
                    self.weather = response
                    
                } else {
                    self.errorMessage = "Invalid city name. Please try again."
                }
            }
        }
    }

    // Handle fetching weather by current location
    private func handleCurrentLocation() {
        locationManager.requestLocation()
    }

    // Fetch weather by geographic coordinates
    private func fetchWeatherByLocation(latitude: Double, longitude: Double) {
        errorMessage = nil // Clear previous errors

        weatherService.fetchWeatherByCoordinates(latitude: latitude, longitude: longitude) { response in
            DispatchQueue.main.async {
                if let response = response {
                    self.weather = response
                } else {
                    self.errorMessage = "Failed to fetch weather data for the current location."
                }
            }
        }
    }
}
