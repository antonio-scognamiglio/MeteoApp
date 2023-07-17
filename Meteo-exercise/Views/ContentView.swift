//
//  ContentView.swift
//  Meteo-exercise
//
//  Created by Antonio Scognamiglio on 13/07/23.
//

import SwiftUI
import CoreLocationUI

struct ContentView: View {
    @State var weatherForecast = WeatherForecast()
    @State var hasFetched = false
    @State var isShowingLoading = false
    let dateComponents = Calendar.current.dateComponents([.hour], from: Date.now)
    @StateObject var viewModel = ContentViewModel()
    
    var body: some View {

        ZStack(alignment: .top) {
                Color.backgroundColor.ignoresSafeArea()
                VStack {
                    HStack{
                        VStack(alignment: .leading) {
                            Text("Latitudine: \(viewModel.coordinates.latitude)")
                                .font(.title2)
                                .fontWeight(.semibold)
                                .foregroundColor(.white)
                            Text("Longitudine: \(viewModel.coordinates.longitude)")
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
                    
                    if hasFetched {
                        
                        Text("Previsione Oraria")
                            .foregroundColor(.white)
                            .fontWeight(.semibold)
                            .frame(maxWidth: .infinity, alignment: .leading)
                        ScrollView(.horizontal) {
                            HStack {
                                ForEach(dateComponents.hour! ... 24, id: \.self){ i in
                                    HourCardView(hour: weatherForecast.hourly?.time?[i] ?? "Error", weatherCode: weatherForecast.hourly?.weathercode?[i] ?? 0, temperature: weatherForecast.strHourlyTemps[i])
    //                                    .padding(.vertical)
                                }
                            }
                        }
                        .id(weatherForecast.id)
                        
                        Text("Previsione Settimanale")
                            .foregroundColor(.white)
                            .fontWeight(.semibold)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.top)
                        
                        WeekWeatherView(dailyWeather: weatherForecast.daily ?? Daily.example)
                            .id(weatherForecast.id)
//                            .padding(.bottom)
                        LocationButton(.currentLocation) {
                            viewModel.requestAllowOnceLocationPermission()
                          
                        }
                        .cornerRadius(15)
                        .foregroundColor(.white)
                        .tint(.cardColor2)
                        .symbolVariant(.fill)
                        .padding(.top)
                    }
                   

                }
                .padding()
            }
        .showLoadingView(isShowingLoading: $isShowingLoading, message: "Caricamento in corso ...", isShowingBackgroundColor: true, backgroundColor: .cardColor2)
    
            .task {
                do {
                    isShowingLoading = true
                    weatherForecast = try await APIHandler.shared.fetchWeatherForecast(latitude: viewModel.strCoordinates.latitude, longitude: viewModel.strCoordinates.longitude)
                    isShowingLoading = false
                    hasFetched = true
                } catch {
                    isShowingLoading = false
                    hasFetched = false
                    print(error.localizedDescription)
                }
        }
        
            .onChange(of: viewModel.coordinates) { _ in
                Task {
                    do {
                        isShowingLoading = true
                        weatherForecast = try await APIHandler.shared.fetchWeatherForecast(latitude: viewModel.strCoordinates.latitude, longitude: viewModel.strCoordinates.longitude)
                        withAnimation {
                            weatherForecast.id = UUID()
                        }
                        isShowingLoading = false
                        hasFetched = true
                    } catch {
                        isShowingLoading = false
                        hasFetched = false
                        print(error.localizedDescription)
                    }
                }
            }
    }
}
    

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(weatherForecast: WeatherForecast.example)
    }
}
