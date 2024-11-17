//
//  WeatherInfoView.swift
//  WeatherApp
//

import SwiftUI

struct WeatherInfoView: View {
    let weather: WeatherResponse?

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
                // Last time update section with right alignment
                if let timestamp = weather.dt {
                    HStack {
                        Spacer()
                        Text("Last Time Update: \(formatTime(from: timestamp))")
                            .font(.footnote)
                            .foregroundColor(.gray)
                    }
                }
                Divider()
                    .padding(.vertical, 10)

                // List for additional weather information with right-aligned values
                List {
                    HStack {
                        Text("Sunrise:")
                        Spacer()
                        if let sunrise = weather.sys?.sunrise {
                            Text(formatTime(from: sunrise))
                        } else {
                            Text("N/A")
                        }
                    }
                    HStack {
                        Text("Sunset:")
                        Spacer()
                        if let sunset = weather.sys?.sunset {
                            Text(formatTime(from: sunset))
                        } else {
                            Text("N/A")
                        }
                    }
                    HStack {
                        Text("Min Temp:")
                        Spacer()
                        Text("\(weather.main.temp_min, specifier: "%.1f")°C")
                    }
                    HStack {
                        Text("Max Temp:")
                        Spacer()
                        Text("\(weather.main.temp_max, specifier: "%.1f")°C")
                    }
                    HStack {
                        Text("Pressure:")
                        Spacer()
                        Text("\(weather.main.pressure) hPa")
                    }
                    HStack {
                        Text("Humidity:")
                        Spacer()
                        Text("\(weather.main.humidity)%")
                    }
                    if let visibility = weather.visibility {
                        HStack {
                            Text("Visibility:")
                            Spacer()
                            Text("\(visibility / 1000) km")
                        }
                    }
                }
                .listStyle(PlainListStyle())
                .frame(maxHeight: .infinity)
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

    private func formatTime(from timestamp: Int) -> String {
        let date = Date(timeIntervalSince1970: TimeInterval(timestamp))
        let dateFormatter = DateFormatter()
        dateFormatter.timeStyle = .short
        dateFormatter.dateStyle = .none
        return dateFormatter.string(from: date)
    }
}
