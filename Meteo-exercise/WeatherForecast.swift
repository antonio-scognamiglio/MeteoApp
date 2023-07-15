//
//  Weather.swift
//  Meteo-exercise
//
//  Created by Antonio Scognamiglio on 14/07/23.
//

import Foundation

struct WeatherForecast: Codable {
    let latitude, longitude, generationtimeMS: Double?
    let utcOffsetSeconds: Int?
    let timezone, timezoneAbbreviation: String?
    let elevation: Int?
    let hourlyUnits: HourlyUnits?
    let hourly: Hourly?
    let dailyUnits: DailyUnits?
    let daily: Daily?
    
    var strCoordinates: (latitude: String, longitude: String) {
        if let lat = (latitude), let long = (longitude) {
            let stringLat = String(format: "%.2f", lat)
            let stringLong = String(format: "%.2f", long)
            return (stringLat, stringLong)
        } else { return ("", "") }
    }
    
    var strHourlyTemps: [String]{
        if let hourlyTemps = hourly?.temperature2M {
            return  hourlyTemps.map { temp in
                String(temp)
            }
        } else {
            return ["Empty"]
        }
    }
    
    init(){
        latitude = Double()
        longitude = Double()
        generationtimeMS = Double()
        utcOffsetSeconds = Int()
        timezone = String()
        timezoneAbbreviation = String()
        elevation = Int()
        hourlyUnits = HourlyUnits(time: String(), temperature2M: String(), precipitation: String(), weathercode: String())
        hourly = Hourly(time: [], temperature2M: [], precipitation: [], weathercode: [])
        dailyUnits = DailyUnits(time: String(), weathercode: String(), temperature2MMax: String(), temperature2MMin: String())
        daily = Daily(time: [], weathercode: [], temperature2MMax: [], temperature2MMin: [])
    }
    
    init(latitude: Double?, longitude: Double?, generationtimeMS: Double?, utcOffsetSeconds: Int?, timezone: String?, timezoneAbbreviation: String?, elevation: Int?, hourlyUnits: HourlyUnits?, hourly: Hourly?, dailyUnits: DailyUnits?, daily: Daily?) {
        self.latitude = latitude
        self.longitude = longitude
        self.generationtimeMS = generationtimeMS
        self.utcOffsetSeconds = utcOffsetSeconds
        self.timezone = timezone
        self.timezoneAbbreviation = timezoneAbbreviation
        self.elevation = elevation
        self.hourlyUnits = hourlyUnits
        self.hourly = hourly
        self.dailyUnits = dailyUnits
        self.daily = daily
    }
    
    static let example = WeatherForecast(
        latitude: 41.9,
        longitude: 12.5,
        generationtimeMS: 4.425048828125,
        utcOffsetSeconds: 0,
        timezone: "GMT",
        timezoneAbbreviation: "GMT",
        elevation: 58,
        hourlyUnits: HourlyUnits.example,
        hourly: Hourly.example,
        dailyUnits: DailyUnits.example,
        daily: Daily.example
    )
}

struct Daily: Codable {
    let time: [String]?
    let weathercode: [Int]?
    let temperature2MMax, temperature2MMin: [Double]?
    
    static let example = Daily(
        time: ["2023-07-14"],
        weathercode: [2],
        temperature2MMax: [35.8],
        temperature2MMin: [24.4]
    )
}


struct DailyUnits: Codable {
    let time, weathercode, temperature2MMax, temperature2MMin: String?
    
    static let example = DailyUnits(
        time: "iso8601",
        weathercode: "wmo code",
        temperature2MMax: "°C",
        temperature2MMin: "°C"
    )
}


struct Hourly: Codable {
    let time: [String]?
    let temperature2M: [Double]?
    let precipitation: [Double]?
    let weathercode: [Int]?
    
//    var stringTemperatures: [String]{
//        if let temperatures = temperature2M {
//            return temperatures.map { temp in
//                String(temp)
//            }
//        } else {
//            return ["allelelelelelell"]
//        }
//    }
    static let example = Hourly(
        time: [
            "2023-07-14T00:00",
            "2023-07-14T01:00",
            "2023-07-14T02:00",
            "2023-07-14T03:00",
            "2023-07-14T04:00",
            "2023-07-14T05:00",
            "2023-07-14T06:00",
            "2023-07-14T07:00",
            "2023-07-14T08:00",
            "2023-07-14T09:00",
            "2023-07-14T10:00",
            "2023-07-14T11:00",
            "2023-07-14T12:00",
            "2023-07-14T13:00",
            "2023-07-14T14:00",
            "2023-07-14T15:00",
            "2023-07-14T16:00",
            "2023-07-14T17:00",
            "2023-07-14T18:00",
            "2023-07-14T19:00",
            "2023-07-14T20:00",
            "2023-07-14T21:00",
            "2023-07-14T22:00",
            "2023-07-14T23:00"
     ],
        temperature2M: [
            26.8,
            26.7,
            25.9,
            26.2,
            25.7,
            26.2,
            26.9,
            27.8,
            29.4,
            31.0,
            32.4,
            33.6,
            33.2,
            33.2,
            32.9,
            32.2,
            31.2,
            30.3,
            29.1,
            28.1,
            27.6,
            27.3,
            27.0,
            26.6
        ],
        precipitation: [
            0.00,
            0.00,
            0.00,
            0.00,
            0.00,
            0.00,
            0.00,
            0.00,
            0.00,
            0.00,
            0.00,
            0.00,
            0.00,
            0.00,
            0.00,
            0.00,
            0.00,
            0.00,
            0.00,
            0.00,
            0.00,
            0.00,
            0.00,
            0.00
        ],
        weathercode: [
            1,
            0,
            0,
            0,
            0,
            0,
            1,
            0,
            0,
            0,
            1,
            1,
            1,
            1,
            0,
            0,
            2,
            2,
            0,
            0,
            0,
            0,
            1,
            2
        ]
    )
}

func getImageCode(for weatherCode: Int) -> String {
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

struct HourlyUnits: Codable {
    let time, temperature2M, precipitation, weathercode: String?
        
    static let example = HourlyUnits(time: "iso8601", temperature2M: "°C", precipitation: "mm", weathercode: "wmo code")
}


