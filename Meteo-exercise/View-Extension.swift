//
//  View-Extension.swift
//  Meteo-exercise
//
//  Created by Antonio Scognamiglio on 15/07/23.
//

import SwiftUI

extension View {
    func getImage(for weatherCode: Int) -> String {
        switch weatherCode {
        case 0 : return "sun.max.fill"
        case 1, 2, 3 : return "cloud.sun.fill"
        case 45, 48:  return "cloud.fog.fill"
        case 51, 53, 55: return "cloud.drizzle"
        case 56, 57: return "cloud.drizzle.fill"
        case 61, 63, 65: return "cloud.heavyrain.fill"
        case 66, 67: return "cloud.sleet"
        case 71, 73, 75: return "cloud.snow.fill"
        case 77: return "cloud.snow"
        case 80, 81, 82: return "cloud.rain.fill"
        case 85, 86: return "cloud.sleet.fill"
        case 95: return "cloud.bolt.fill"
        case 96, 99: return "cloud.bolt.rain"
        default: return "sun.max.fill"
        }
    }

    func getWeatherName(for weatherCode: Int) -> String {
        switch weatherCode {
        case 0: return "Clear sky"
        case 1: return "Mainly clear"
        case 2: return "Partly cloudy"
        case 3: return "Overcast"
        case 45: return "Fog"
        case 48: return "Depositing rime fog"
        case 51: return "Drizzle light intensity"
        case 53: return "Drizzle moderate intensity"
        case 55: return "Drizzle dense intensity"
        case 56: return "Freezing Drizzle light intensity"
        case 57: return "Freezing Drizzle dense intensity"
        case 61: return "Rain slight intensity"
        case 63: return "Rain moderate intensity"
        case 65: return "Rain heavy intensity"
        case 66: return "Freezing Rain Light intensity"
        case 67: return "Freezing Rain heavy intensity"
        case 71: return "Snow fall slight intensity"
        case 73: return "Snow fall moderate intensity"
        case 75: return "Snow fall heavy intensity"
        case 77: return "Snow grains"
        case 80: return "Rain shower slight"
        case 81: return "Rain shower moderate"
        case 82: return "Rain shower violent"
        case 85: return "Snow showers slight"
        case 86: return "Snow showers heavy"
        case 95: return "Thunderstorm: Slight or moderate"
        case 96: return "Thunderstorm with slight hail"
        case 99: return "Thunderstorm with heavy hail"
        default: return "Clear sky"
        }
    }

    func formatHour(from date: String?) -> String {
        if let date = date {
            let apiDateFormatter = DateFormatter()
            // iso8601
            apiDateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm"
            guard let newDate = apiDateFormatter.date(from: date) else { return "Failed conversion"}
            return newDate.formatted(.dateTime.hour().locale(Locale(identifier: "it")))
//            return newDate.formatted(date: .omitted, time: .shortened)
        } else {
            return "Invalid input Date"
        }
    }
    
    func formatWeekDay(from date: String?) -> String {
        if let date = date {
            let apiDateFormatter = DateFormatter()
            apiDateFormatter.dateFormat = "yyyy-MM-dd"
            guard let newDate = apiDateFormatter.date(from: date) else { return "Failed conversion"}
            let weekDateFormatter = DateFormatter()
            weekDateFormatter.dateFormat = "EEEE"
            weekDateFormatter.locale = Locale(identifier: "it_IT")
            return weekDateFormatter.string(from: newDate)
        } else {
            return "Invalid input Date"
        }
    }
}
