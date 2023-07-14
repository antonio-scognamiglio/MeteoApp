//
//  ContentView.swift
//  Meteo-exercise
//
//  Created by Antonio Scognamiglio on 13/07/23.
//

import SwiftUI

struct ContentView: View {
    @State var weatherForecast: WeatherForecast?
    
    var strCoordinates: (latitude: String, longitude: String) {
        if let lat = (weatherForecast?.latitude), let long = (weatherForecast?.longitude) {
            let stringLat = String(format: "%.2f", lat)
            let stringLong = String(format: "%.2f", long)
            return (stringLat, stringLong)
        } else { return ("", "") }
    }
    
    
    var body: some View {
        VStack {
            Text("Latitudine: \(strCoordinates.latitude)")
                .fontWeight(.semibold)
                .font(.title)
            Text("Longitudine: \(strCoordinates.longitude)")
                .font(.title)
                .fontWeight(.semibold)
        }
        .padding()
        .task {
            do {
               weatherForecast = try await APIHandler.shared.fetchWeatherForecast()
            } catch {
                print(error.localizedDescription)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(weatherForecast: WeatherForecast.example)
    }
}
