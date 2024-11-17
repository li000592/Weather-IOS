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
