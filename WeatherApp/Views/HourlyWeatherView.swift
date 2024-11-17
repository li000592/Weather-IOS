//
//  HourlyWeatherView.swift
//  WeatherApp
//

import SwiftUI

struct HourlyWeatherView: View {
    @State private var hourlyWeather: [HourlyWeather] = [] // State variable to hold fetched hourly data
    @State private var isLoading: Bool = true // State to track loading status
    @State private var errorMessage: String? // Holds error messages
    let city: String // City name passed to the view
    private let weatherService = WeatherService() // Instance of WeatherService

    var body: some View {
        VStack {
            if isLoading {
                ProgressView("Loading hourly weather...")
                    .padding()
            } else if let errorMessage = errorMessage {
                Text(errorMessage)
                    .font(.subheadline)
                    .foregroundColor(.red)
                    .padding()
            } else if !hourlyWeather.isEmpty {
                // Display the hourly weather using a List
                List(hourlyWeather) { weather in
                    HStack {
                        Text(weather.time)
                            .font(.subheadline)
                            .frame(maxWidth: .infinity, alignment: .leading)
                        
                        // Display the weather icon
                        if let icon = weather.icon, let url = URL(string: "https://openweathermap.org/img/wn/\(icon)@2x.png") {
                            AsyncImage(url: url) { image in
                                image
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 30, height: 30) // Adjust size as needed
                            } placeholder: {
                                Image(systemName: "cloud.fill")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 30, height: 30)
                                    .foregroundColor(.gray)
                            }
                            .frame(maxWidth: .infinity)
                        } else {
                            Image(systemName: "questionmark.circle")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 30, height: 30)
                                .foregroundColor(.gray)
                                .frame(maxWidth: .infinity)
                        }
                        
                        Text("\(weather.temperature, specifier: "%.1f")°C")
                            .font(.caption)
                            .frame(maxWidth: .infinity, alignment: .trailing)
                    }
                }
                .listStyle(PlainListStyle())
            } else {
                Text("No hourly data available")
                    .font(.subheadline)
                    .foregroundColor(.gray)
                    .padding()
            }
        }
        .onAppear {
            fetchHourlyWeather()
        }
        .padding()
    }

    private func fetchHourlyWeather() {
        weatherService.fetchHourlyWeather(city: city) { response in
            DispatchQueue.main.async {
                if let response = response {
                    // Filter and sort the fetched hourly weather data
                    let now = Date()
                    let filteredSortedData = response.list.compactMap { forecast -> HourlyWeather? in
                        guard let dateString = forecast.dt_txt, let date = parseDate(dateString) else {
                            return nil
                        }
                        // Only include future hours
                        guard date > now else { return nil }
                        return HourlyWeather(
                            time: formatDate(dateString),
                            temperature: forecast.main.temp,
                            condition: forecast.weather.first?.description.capitalized ?? "Unknown",
                            icon: forecast.weather.first?.icon ?? "01d", // Default or placeholder icon
                            date: date // Add the date parameter here for sorting
                        )
                    }
                    // Sort by date ascending
                    .sorted(by: { $0.date < $1.date })

                    self.hourlyWeather = filteredSortedData
                    self.isLoading = false
                } else {
                    self.errorMessage = "Failed to load hourly weather data."
                    self.isLoading = false
                }
            }
        }
    }
}
