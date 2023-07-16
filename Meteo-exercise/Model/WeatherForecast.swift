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
                String(Int(temp.rounded()))
            }
        } else {
            return ["Empty"]
        }
    }
    
    
    
    enum CodingKeys: String, CodingKey {
           case latitude, longitude
           case generationtimeMS = "generationtime_ms"
           case utcOffsetSeconds = "utc_offset_seconds"
           case timezone
           case timezoneAbbreviation = "timezone_abbreviation"
           case elevation
           case hourlyUnits = "hourly_units"
           case hourly
           case dailyUnits = "daily_units"
           case daily
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
    
    var stringTempMax: [String] {
        if let temps = temperature2MMax {
            return temps.map { temp in
//                temp.convertToString()
                String(Int(temp))
            }
        } else {
            return []
        }
    }
    
    var stringTempMin: [String] {
        if let temps = temperature2MMin {
            return temps.map { temp in
//                temp.convertToString()
                String(Int(temp))
            }
        } else {
            return []
        }
    }
    
    static let example = Daily(
        time: ["2023-07-14"],
        weathercode: [2],
        temperature2MMax: [35.8],
        temperature2MMin: [24.4]
    )
    
    enum CodingKeys: String, CodingKey {
           case time, weathercode
           case temperature2MMax = "temperature_2m_max"
           case temperature2MMin = "temperature_2m_min"
    }
}


struct DailyUnits: Codable {
    let time, weathercode, temperature2MMax, temperature2MMin: String?
    
    static let example = DailyUnits(
        time: "iso8601",
        weathercode: "wmo code",
        temperature2MMax: "°C",
        temperature2MMin: "°C"
    )
    
    enum CodingKeys: String, CodingKey {
            case time, weathercode
            case temperature2MMax = "temperature_2m_max"
            case temperature2MMin = "temperature_2m_min"
        }
}


struct Hourly: Codable {
    let time: [String]?
    let temperature2M: [Double]?
    let precipitation: [Double]?
    let weathercode: [Int]?
    
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
    
    enum CodingKeys: String, CodingKey {
            case time
            case temperature2M = "temperature_2m"
            case precipitation, weathercode
        }
}

struct HourlyUnits: Codable {
    let time, temperature2M, precipitation, weathercode: String?
        
    static let example = HourlyUnits(time: "iso8601", temperature2M: "°C", precipitation: "mm", weathercode: "wmo code")
    
    enum CodingKeys: String, CodingKey {
           case time
           case temperature2M = "temperature_2m"
           case precipitation, weathercode
       }
}

