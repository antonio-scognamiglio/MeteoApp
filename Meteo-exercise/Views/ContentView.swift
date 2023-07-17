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
    
    init() {
        UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor: UIColor.white]
    }
    
    var body: some View {

        NavigationView {
            ZStack(alignment: .top) {
                    Color.backgroundColor.ignoresSafeArea()
                    VStack {
                        HStack{
                            VStack(alignment: .leading) {
                                Text("Latitudine: \t \(viewModel.coordinates.latitude)")
                                    .font(.headline)
                                    .fontWeight(.semibold)
                                    .foregroundColor(.white)
                                Text("Longitudine: \t \(viewModel.coordinates.longitude)")
                                    .font(.headline)
                                    .fontWeight(.semibold)
                                    .foregroundColor(.white)
                            }
                            Spacer()
                            
                            Image(systemName: getImage(for: (weatherForecast.daily?.weathercode?.first ?? WeatherForecast.example.daily?.weathercode?.first)!))
                                .font(.system(size: 60))
                                .foregroundColor(.yellow)
                                .padding(.trailing, 30)

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
     
                                    }
                                }
                            }
                            .animation(.easeIn, value: viewModel.coordinates)
                            .scrollIndicators(.hidden)
                            
                            Text("Previsione Settimanale")
                                .foregroundColor(.white)
                                .fontWeight(.semibold)
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .padding(.top)
                            
                            WeekWeatherView(dailyWeather: weatherForecast.daily ?? Daily.example)
                                .animation(.easeIn, value: viewModel.coordinates)
                            LocationButton(.currentLocation) {
                                viewModel.isLoading = true
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
            .showLoadingView(isShowingLoading: $isShowingLoading, message: "Caricamento in corso...", isShowingBackgroundColor: true, backgroundColor: .cardColor2)
            .showLoadingView(isShowingLoading: $viewModel.isLoading, message: "Ottengo la posizione...", isShowingBackgroundColor: true, backgroundColor: .cardColor2)
        
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
                            weatherForecast = try await APIHandler.shared.fetchWeatherForecast(latitude: viewModel.strCoordinates.latitude, longitude: viewModel.strCoordinates.longitude)
                            viewModel.isLoading = false
                            hasFetched = true

                        } catch {
                            viewModel.isLoading = false
                            hasFetched = false

                            print(error.localizedDescription)
                        }
                    }
            }
                .navigationTitle("Meteo")
        }
    }
}
    

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
