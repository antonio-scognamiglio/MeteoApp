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

struct HourlyUnits: Codable {
    let time, temperature2M, precipitation, weathercode: String?
        
    static let example = HourlyUnits(time: "iso8601", temperature2M: "°C", precipitation: "mm", weathercode: "wmo code")
}
