//
//  HeaderView.swift
//  WeatherApp
//
//  Created by Haorong Li on 2024-11-16.
//

// File: HeaderView.swift

import SwiftUI

struct HeaderView: View {
    var body: some View {
        HStack {
            Image(systemName: "sun.max.fill") // Replace with your custom logo if available
                .resizable()
                .frame(width: 40, height: 40)
                .padding(.leading)

            Text("Weather App")
                .font(.largeTitle)
                .fontWeight(.bold)
                .padding(.leading, 10)

            Spacer() // Pushes content to the left side
        }
        .padding()
        .background(Color(hex: "#00d1b2")) // Adding background color using hex value
        .foregroundColor(.white) // Optional: Set text and icon color to white for contrast
    }
}

struct HeaderView_Previews: PreviewProvider {
    static var previews: some View {
        HeaderView()
    }
}

extension Color {
    init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hex.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (255, 0, 0, 0)
        }
        self.init(
            .sRGB,
            red: Double(r) / 255,
            green: Double(g) / 255,
            blue: Double(b) / 255,
            opacity: Double(a) / 255
        )
    }
}
