//
//  ContentView.swift
//  Meteo-exercise
//
//  Created by Antonio Scognamiglio on 13/07/23.
//

import SwiftUI

struct ContentView: View {
    @State var weatherForecast = WeatherForecast()
    @State var hasFetched = false
    
//    var strHourlyTemps: [String]{
//        if let hourlyTemps = weatherForecast.hourly?.temperature2M {
//            return  hourlyTemps.map { temp in
//                String(temp)
//            }
//        } else {
//            return ["Empty"]
//        }
//    }
    var backgroundColor = #colorLiteral(red: 0.5262038708, green: 0.7596305013, blue: 0.912558496, alpha: 1)
    var backgroundColor2 = #colorLiteral(red: 0.968627451, green: 0.9490196078, blue: 0.8509803922, alpha: 1)
    
    var body: some View {
        ZStack {
            Color(backgroundColor).ignoresSafeArea()
            VStack {
                HStack {
                    VStack(alignment: .leading) {
                        Text("Latitudine: \(weatherForecast.strCoordinates.latitude)")
                            .font(.title2)
                            .fontWeight(.semibold)
                            .foregroundColor(.white)
                        Text("Longitudine: \(weatherForecast.strCoordinates.longitude)")
                            .font(.title2)
                            .fontWeight(.semibold)
                            .foregroundColor(.white)
                    }
                    Spacer()
                    Image(systemName: getImageCode(for: (weatherForecast.daily?.weathercode?.first ?? WeatherForecast.example.daily?.weathercode?.first)!))
                        .resizable()
                        .foregroundColor(.yellow)
                        .scaledToFit()
                }
                
                Text("Today")
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                if hasFetched {
                    ForEach(weatherForecast.strHourlyTemps, id: \.self){ temp in
                            Text("Temperature: \(temp)")
                        }
                }
            }
                
            .padding()
        }
        .task {
            do {
                weatherForecast = try await APIHandler.shared.fetchWeatherForecast()
                hasFetched = true
            } catch {
                hasFetched = false
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
