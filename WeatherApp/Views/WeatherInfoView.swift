//
//  WeatherInfoView.swift
//  WeatherApp
//

import SwiftUI

struct WeatherInfoView: View {
    let weather: WeatherResponse?
    @State private var selectedView: Int = 0 // 0 for current weather, 1 for hourly weather
    var body: some View {
        VStack(spacing: 10) {
            if let weather = weather {
                // Weather Icon and Main Info
                HStack(alignment: .center, spacing: 10) {
                    if let iconCode = weather.weather.first?.icon {
                        AsyncImage(url: URL(string: "https://openweathermap.org/img/wn/\(iconCode)@4x.png")) { image in
                            image
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 120, height: 120)
                        } placeholder: {
                            Image(systemName: "cloud.fill")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 120, height: 120)
                                .foregroundColor(.gray)
                        }
                    } else {
                        Image(systemName: "cloud.fill")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 120, height: 120)
                            .foregroundColor(.gray)
                    }

                    VStack(alignment: .leading) {
                        Text("\(weather.name)")
                            .font(.title)

                        Text("\(weather.main.temp, specifier: "%.1f")°C")
                            .font(.system(size: 60, weight: .bold))
                            .padding(.bottom, 5)

                        Text(weather.weather.first?.description.capitalized ?? "No Data")
                            .font(.subheadline)

                        Text("Feels like: \(weather.main.feels_like, specifier: "%.1f")°C")
                            .font(.subheadline)
                    }
                }

                // Divider
//                Divider()
//                    .padding(.vertical, 10)

                // Weather Details View
                Picker("Select View", selection: $selectedView) {
                    Text("Current Weather").tag(0)
                    Text("Hourly Weather").tag(1)
                }
                .pickerStyle(SegmentedPickerStyle())

                if selectedView == 0 {
                    WeatherDetailsView(weather: weather)
                } else if selectedView == 1 {
                    HourlyWeatherView(city: weather.name)
                }
            } else {
                // Placeholder view when no data is available
                VStack {
                    Image(systemName: "questionmark.circle")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 100, height: 100)
                        .foregroundColor(.gray)
                    Text("No weather data available")
                        .font(.headline)
                        .foregroundColor(.gray)
                    Text("Please search for a location to view weather data.")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                        .padding(.top, 5)
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            }
            Spacer()
        }
        .padding()
    }
}
