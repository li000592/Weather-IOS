//
//  WeatherUtilities.swift
//  WeatherApp
//

import Foundation

// Helper function to parse date strings
func parseDate(_ dateString: String) -> Date? {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss" // Match your API's date format
    dateFormatter.timeZone = TimeZone(abbreviation: "UTC") // Adjust this as needed
    return dateFormatter.date(from: dateString)
}

// Helper function to format dates for display
func formatDate(_ dateString: String) -> String {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
    if let date = dateFormatter.date(from: dateString) {
        dateFormatter.dateFormat = "h a" // Format to display hours (e.g., "1 PM")
        return dateFormatter.string(from: date)
    }
    return dateString
}

// Helper function to format timestamps to human-readable time
func formatTime(from timestamp: Int) -> String {
    let date = Date(timeIntervalSince1970: TimeInterval(timestamp))
    let dateFormatter = DateFormatter()
    dateFormatter.timeStyle = .short
    dateFormatter.dateStyle = .none
    return dateFormatter.string(from: date)
}
