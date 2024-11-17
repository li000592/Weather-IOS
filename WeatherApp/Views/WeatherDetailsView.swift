//
//  WeatherDetailsView.swift
//  WeatherApp
//

import SwiftUI

struct WeatherDetailsView: View {
    let weather: WeatherResponse

 

    var body: some View {
        VStack {
                // Display current weather details
                List {
                    HStack {
                        Text("Sunrise")
                        Spacer()
                        if let sunrise = weather.sys?.sunrise {
                            Text(formatTime(from: sunrise))
                        } else {
                            Text("N/A")
                        }
                    }
                    HStack {
                        Text("Sunset")
                        Spacer()
                        if let sunset = weather.sys?.sunset {
                            Text(formatTime(from: sunset))
                        } else {
                            Text("N/A")
                        }
                    }
                    HStack {
                        Text("Min Temp")
                        Spacer()
                        Text("\(weather.main.temp_min, specifier: "%.1f")°C")
                    }
                    HStack {
                        Text("Max Temp")
                        Spacer()
                        Text("\(weather.main.temp_max, specifier: "%.1f")°C")
                    }
                    HStack {
                        Text("Pressure")
                        Spacer()
                        Text("\(weather.main.pressure) hPa")
                    }
                    HStack {
                        Text("Humidity")
                        Spacer()
                        Text("\(weather.main.humidity)%")
                    }
                    if let visibility = weather.visibility {
                        HStack {
                            Text("Visibility")
                            Spacer()
                            Text("\(visibility / 1000) km")
                        }
                    }
                }
                .listStyle(PlainListStyle())
                .frame(maxHeight: .infinity)
        }
    }
}
