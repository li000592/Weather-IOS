//
//  WeatherService.swift
//  WeatherApp
//

import Foundation

struct WeatherResponse: Codable {
    let main: Main
    let weather: [Weather]
    let name: String
}

struct Main: Codable {
    let temp: Double
    let humidity: Int
}

struct Weather: Codable {
    let description: String
    let icon: String
}

class WeatherService {
    private let apiKey = "YOUR_API_KEY" // Replace with your actual API key

    func fetchWeather(city: String, completion: @escaping (WeatherResponse?) -> Void) {
        let encodedCity = city.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? city
        let urlString = "https://api.openweathermap.org/data/2.5/weather?q=\(encodedCity)&appid=\(apiKey)&units=metric"
        guard let url = URL(string: urlString) else {
            completion(nil)
            return
        }

        performRequest(with: url, completion: completion)
    }

    func fetchWeatherByCoordinates(latitude: Double, longitude: Double, completion: @escaping (WeatherResponse?) -> Void) {
        let urlString = "https://api.openweathermap.org/data/2.5/weather?lat=\(latitude)&lon=\(longitude)&appid=\(apiKey)&units=metric"
        guard let url = URL(string: urlString) else {
            completion(nil)
            return
        }

        performRequest(with: url, completion: completion)
    }

    private func performRequest(with url: URL, completion: @escaping (WeatherResponse?) -> Void) {
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print("Error fetching data: \(error.localizedDescription)")
                completion(nil)
                return
            }

            if let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode != 200 {
                print("Error: HTTP status code \(httpResponse.statusCode)")
                completion(nil)
                return
            }

            guard let data = data else {
                print("Error: No data received")
                completion(nil)
                return
            }

            do {
                let weatherResponse = try JSONDecoder().decode(WeatherResponse.self, from: data)
                DispatchQueue.main.async {
                    completion(weatherResponse)
                }
            } catch {
                print("Error decoding data: \(error.localizedDescription)")
                DispatchQueue.main.async {
                    completion(nil)
                }
            }
        }.resume()
    }
}
