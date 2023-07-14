//
//  ContentView.swift
//  Meteo-exercise
//
//  Created by Antonio Scognamiglio on 13/07/23.
//

import SwiftUI

struct ContentView: View {
    @State var weatherForecast: WeatherForecast?
    
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundColor(.accentColor)
            Text("Hello, world!")
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
