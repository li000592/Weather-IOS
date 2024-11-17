//
//  WeatherService.swift
//  WeatherApp
//

import Foundation

class WeatherService {
    private var apiKey: String {
        guard let path = Bundle.main.path(forResource: "Secrets", ofType: "plist"),
              let dict = NSDictionary(contentsOfFile: path),
              let key = dict["API_KEY"] as? String else {
            fatalError("API Key not found. Please ensure Secrets.plist is configured correctly.")
        }
        return key
    }

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

    func fetchHourlyWeather(city: String, completion: @escaping (HourlyWeatherResponse?) -> Void) {
        let encodedCity = city.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? city
        let urlString = "https://api.openweathermap.org/data/2.5/forecast?q=\(encodedCity)&appid=\(apiKey)&units=metric"
        guard let url = URL(string: urlString) else {
            completion(nil)
            return
        }

        performHourlyRequest(with: url, completion: completion)
    }

    private func performRequest(with url: URL, completion: @escaping (WeatherResponse?) -> Void) {
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print("Error fetching data: \(error.localizedDescription)")
                DispatchQueue.main.async {
                    completion(nil)
                }
                return
            }

            if let httpResponse = response as? HTTPURLResponse, !(200...299).contains(httpResponse.statusCode) {
                print("Error: HTTP status code \(httpResponse.statusCode)")
                DispatchQueue.main.async {
                    completion(nil)
                }
                return
            }

            guard let data = data else {
                print("Error: No data received")
                DispatchQueue.main.async {
                    completion(nil)
                }
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
        }
        task.resume()
    }

    private func performHourlyRequest(with url: URL, completion: @escaping (HourlyWeatherResponse?) -> Void) {
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print("Error fetching hourly data: \(error.localizedDescription)")
                DispatchQueue.main.async {
                    completion(nil)
                }
                return
            }

            if let httpResponse = response as? HTTPURLResponse, !(200...299).contains(httpResponse.statusCode) {
                print("Error: HTTP status code \(httpResponse.statusCode)")
                DispatchQueue.main.async {
                    completion(nil)
                }
                return
            }

            guard let data = data else {
                print("Error: No data received")
                DispatchQueue.main.async {
                    completion(nil)
                }
                return
            }

            do {
                let hourlyResponse = try JSONDecoder().decode(HourlyWeatherResponse.self, from: data)
                DispatchQueue.main.async {
                    completion(hourlyResponse)
                }
            } catch {
                print("Error decoding hourly data: \(error.localizedDescription)")
                DispatchQueue.main.async {
                    completion(nil)
                }
            }
        }
        task.resume()
    }
}
