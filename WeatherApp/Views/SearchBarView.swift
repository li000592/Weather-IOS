//
//  SearchBarView.swift
//  WeatherApp
//

import SwiftUI
import CoreLocation // Ensure this is imported for CLLocation and CLGeocoder

struct SearchBarView: View {
    @Binding var city: String
    var onSearch: () -> Void
    var onFetchCurrentLocation: () -> Void
    var errorMessage: String? // Optional error message to show in the placeholder
    @ObservedObject private var locationManager = LocationManager() // Assuming you have a LocationManager
    @State private var isRequestingLocation: Bool = false // Added state variable

    var body: some View {
        VStack(spacing: 10) {
            // iOS-style search bar with TextField
            HStack {
                Image(systemName: "magnifyingglass")
                    .foregroundColor(.gray)
                    .padding(.leading, 8)
                
                TextField(errorMessage ?? "Search for a city...", text: $city)
                    .padding(10)
                    .background(Color(.systemGray6)) // Light gray background for input
                    .cornerRadius(10)
                    .onSubmit {
                        onSearch() // Trigger search action on pressing return
                    }
                
                if !city.isEmpty {
                    Button(action: {
                        city = "" // Clear text action
                    }) {
                        Image(systemName: "xmark.circle.fill")
                            .foregroundColor(.gray)
                    }
                    .padding(.trailing, 8)
                }
            }
            .padding(.horizontal)
            .background(Color(.systemGray6))
            .cornerRadius(10)
            .padding(.horizontal)

            // Buttons below the search bar
            HStack {
                Spacer() // Pushes buttons to the right
                // Button to get weather for the current location
                Button(action: {
                    isRequestingLocation = true
                    locationManager.requestLocation()
                }) {
                    Image(systemName: isRequestingLocation ? "location.circle" : "location.fill")
                        .padding(10)
                        .background(Color(hex: "#00d1b2"))
                        .foregroundColor(.white)
                        .cornerRadius(8)
                }
                .disabled(isRequestingLocation)
                Button(action: onSearch) {
                    Image(systemName: "magnifyingglass")
                        .padding(10)
                        .background(Color(hex: "#00d1b2"))
                        .foregroundColor(.white)
                        .cornerRadius(8)
                }
            }
            .padding(.horizontal)
        }
        .onChange(of: locationManager.location) { newLocation in
            if let location = newLocation {
                let geocoder = CLGeocoder()
                geocoder.reverseGeocodeLocation(location) { placemarks, error in
                    isRequestingLocation = false

                    if let error = error {
                        print("Geocoding error: \(error.localizedDescription)")
                        return
                    }

                    if let placemark = placemarks?.first,
                       let cityName = placemark.locality {
                        city = cityName
                        onSearch()
                    }
                }
            }
        }
        .onChange(of: locationManager.errorMessage) { error in
            if let error = error {
                isRequestingLocation = false
                print("Location error: \(error)")
            }
        }
    }
}
