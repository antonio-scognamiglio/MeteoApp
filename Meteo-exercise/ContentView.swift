//
//  ContentView.swift
//  Meteo-exercise
//
//  Created by Antonio Scognamiglio on 13/07/23.
//

import SwiftUI

struct ContentView: View {
    @State var weatherForecast: WeatherForecast?
    var backgroundColor = #colorLiteral(red: 0.5262038708, green: 0.7596305013, blue: 0.912558496, alpha: 1)
    var backgroundColor2 = #colorLiteral(red: 0.968627451, green: 0.9490196078, blue: 0.8509803922, alpha: 1)
    var strCoordinates: (latitude: String, longitude: String) {
        if let lat = (weatherForecast?.latitude), let long = (weatherForecast?.longitude) {
            let stringLat = String(format: "%.2f", lat)
            let stringLong = String(format: "%.2f", long)
            return (stringLat, stringLong)
        } else { return ("", "") }
    }
    
    
    var body: some View {
        ZStack {
            Color(backgroundColor).ignoresSafeArea()
            HStack {
                VStack(alignment: .leading) {
                    Text("Latitudine: \(strCoordinates.latitude)")
                        .font(.title2)
                        .fontWeight(.semibold)
                    Text("Longitudine: \(strCoordinates.longitude)")
                        .font(.title2)
                        .fontWeight(.semibold)
                }
                Spacer()
                Image(systemName: "sun.and.horizon.circle.fill")
                    .resizable()
                    .foregroundColor(.yellow)
                    .scaledToFit()
            }
            .padding()
        }
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
