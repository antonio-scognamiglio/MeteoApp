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
    let dateComponents = Calendar.current.dateComponents([.hour], from: Date.now)

    
    var body: some View {
        ZStack {
            Color.backgroundColor.ignoresSafeArea()
            VStack {
                HStack{
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
                    Image(systemName: getImage(for: (weatherForecast.daily?.weathercode?.first ?? WeatherForecast.example.daily?.weathercode?.first)!))
                        .font(.system(size: 64))
                        .foregroundColor(.yellow)

                }
                .padding(.vertical)
                
                Text("Today")
                    .foregroundColor(.white)
                    .fontWeight(.semibold)
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                if hasFetched {
                    ScrollView(.horizontal) {
                        HStack {
                            ForEach(dateComponents.hour! ... 24, id: \.self){ i in
                                HourCardView(hour: weatherForecast.hourly?.time?[i] ?? "Error", weatherCode: weatherForecast.hourly?.weathercode?[i] ?? 0, temperature: weatherForecast.strHourlyTemps[i])
//                                    .padding(.vertical)
                            }
                        }
                    }
                }
                Spacer()
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
