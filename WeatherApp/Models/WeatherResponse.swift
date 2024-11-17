//
//  WeatherResponse.swift
//  WeatherApp
//

import Foundation

struct WeatherResponse: Codable {
    let name: String
    let main: Main
    let weather: [Weather]
    let sys: Sys?
    let visibility: Int?
    let dt: Int?

    struct Main: Codable {
        let temp: Double
        let feels_like: Double
        let temp_min: Double
        let temp_max: Double
        let pressure: Int
        let humidity: Int
        let sea_level: Int?
        let grnd_level: Int?
    }

    struct Weather: Codable {
        let description: String
        let icon: String
    }

    struct Sys: Codable {
        let sunrise: Int
        let sunset: Int
    }
}

struct HourlyWeatherResponse: Codable {
    let list: [HourlyForecast]

    struct HourlyForecast: Codable {
        let dt: Int
        let main: Main
        let weather: [Weather]
        let dt_txt: String?

        struct Main: Codable {
            let temp: Double
            let temp_min: Double
            let temp_max: Double
            let pressure: Int
            let humidity: Int
        }

        struct Weather: Codable {
            let description: String
            let icon: String
        }
    }
}

// Struct for representing hourly weather data
struct HourlyWeather: Identifiable {
    let id = UUID() // Conform to Identifiable for List
    let time: String
    let temperature: Double
    let condition: String
    let icon: String?
    let date: Date // Added date property for sorting
}
