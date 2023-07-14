//
//  APIHandler.swift
//  Meteo-exercise
//
//  Created by Antonio Scognamiglio on 14/07/23.
//

import Foundation

class APIHandler {
    static let shared = APIHandler()
    
    private init() { }
    
    func fetchWeatherForecast(latitude: Double = 41.9027835, longitude: Double = 12.4963655, forecastDays: Int = 7) async throws -> WeatherForecast {
        let endpoint = "https://api.open-meteo.com/v1/forecast"
        let query = "?latitude=\(latitude)&longitude=\(longitude)&hourly=temperature_2m,precipitation,weathercode&daily=weathercode,temperature_2m_max,temperature_2m_min&timezone=GMT&forecast_days=\(forecastDays)"
        
        guard let url = URL(string: (endpoint + query).addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!) else { throw NetworkError.invalidUrl }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        let (data, response) = try await URLSession.shared.data(for: request)
        
        let verifiedData = try mapResponse(response: (data, response))

//        print(String(decoding: verifiedData, as: UTF8.self))
        let weatherObject = try JSONDecoder().decode(WeatherForecast.self, from: verifiedData)
        print("Tutto a posto")
        return weatherObject
    }
}
