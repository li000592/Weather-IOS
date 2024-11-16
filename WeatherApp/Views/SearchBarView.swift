//
//  SearchBarView.swift
//  WeatherApp
//
//  Created by Haorong Li on 2024-11-16.
//

import SwiftUI

struct SearchBarView: View {
    @Binding var city: String
    var onSearch: () -> Void
    var onFetchCurrentLocation: () -> Void // New closure for fetching current location weather

    var body: some View {
        HStack {
            // Search TextField with rounded border
            TextField("Enter city name", text: $city)
                .padding(10)
                .background(Color(.systemGray6)) // Light background for input
                .cornerRadius(10)
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color.gray, lineWidth: 1) // Border for the TextField
                )
                .padding(.horizontal)

            // Search Button (magnifying glass icon)
            Button(action: onSearch) {
                Image(systemName: "magnifyingglass")
                    .padding(10)
                    .background(Color(hex: "#00d1b2"))
                    .foregroundColor(.white)
                    .cornerRadius(8)
            }
            .padding(.trailing, 8)

            // Button to get weather for the current location
            Button(action: onFetchCurrentLocation) {
                Image(systemName: "location.fill") // SF Symbol for location icon
                    .padding(10)
                    .background(Color(hex: "#00d1b2"))
                    .foregroundColor(.white)
                    .cornerRadius(8)
            }
            .padding(.trailing)
        }
    }
}

struct SearchBarView_Previews: PreviewProvider {
    @State static var city = ""
    static var previews: some View {
        SearchBarView(city: $city, onSearch: {}, onFetchCurrentLocation: {})
    }
}
