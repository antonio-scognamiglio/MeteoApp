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
    @State private var searchText = ""
    @StateObject var viewModel = ContentViewModel()
    @State private var selectedLocation: String?
    var searchResults: [Location] {
        if searchText.isEmpty {
            return []
        } else {
            return locations.filter { location in
                if let cityName = location.comune {
                    return cityName.contains(searchText)
                } else {
                    return false
                }
            }
        }
    }
    
    let dateComponents = Calendar.current.dateComponents([.hour], from: Date.now)
    let locations: [Location] = Bundle.main.decode("italy_geo.json")
    
    init() {
        UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor: UIColor.white]

    }
    
    var body: some View {

        NavigationStack {
            GeometryReader { geo in
                ZStack(alignment: .top) {
                        Color.backgroundColor.ignoresSafeArea()
                        VStack {
                            HStack(alignment: .lastTextBaseline) {
                                    VStack(alignment: .leading) {
                                    
                                        Text(selectedLocation ?? "Posizione attuale")
                                            .font(.title3)
                                            .fontWeight(.bold)
                                            .foregroundColor(.white)
                                            .padding(.bottom, 2)
                                        
                                        Text("Latitudine: \t\t\(viewModel.coordinates.latitude)")
                                            .font(.headline)
                                            .fontWeight(.semibold)
                                            .foregroundColor(.white)
                                            .fixedSize()
                                        Text("Longitudine: \t\(viewModel.coordinates.longitude)")
                                            .font(.headline)
                                            .fontWeight(.semibold)
                                            .foregroundColor(.white)
                                            .fixedSize()
                                    }
                                    Spacer()
                                    
                                    Image(systemName: getImage(for: (weatherForecast.daily?.weathercode?.first ?? WeatherForecast.example.daily?.weathercode?.first)!))
                                        .font(.system(size: 70))
                                        .foregroundColor(.yellow)
//                                        .padding(.trailing, 20)
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
                                        withAnimation {
//                                            viewModel.isLoading = true
                                            selectedLocation = nil
                                            viewModel.requestAllowOnceLocationPermission()
                                        }
                                    
                                    }
                                    .cornerRadius(15)
                                    .foregroundColor(.white)
                                    .tint(.cardColor2)
                                    .symbolVariant(.fill)
                                    .padding(.top)
                                    
                                }
                            }
                        .padding(.horizontal)
                        .ignoresSafeArea(.keyboard)
                        .animation(Animation.linear, value: geo.size.height)

                    }
                .overlay {
                    if !searchText.isEmpty {
                            List {
                                ForEach(searchResults, id: \.istat) { location in
                                    Button {
                                        Task {
                                            do {
                                                hideKeyboard()
                                                searchText = ""
                                                isShowingLoading = true
                                                weatherForecast = try await APIHandler.shared.fetchWeatherForecast(latitude: location.latitude ?? "41.9027835", longitude: location.longitude ?? "12.4963655")
                                                withAnimation {
                                                    selectedLocation = location.comune
                                                    if let lat = location.latitude, let long = location.longitude {
                                                        viewModel.coordinates.latitude = Double(lat) ?? 41.9027835
                                                        viewModel.coordinates.longitude = Double(long) ?? 12.4963655
                                                    }
                                                    isShowingLoading = false
                                                }
                                            } catch {
                                                isShowingLoading = false
                                                print(error.localizedDescription)
                                            }
                                        }
                                        //
                                    } label: {
                                        Text(location.comune ?? "Errore")
                                            .foregroundColor(Color.primary)
                                    }
                                }
                            }
                            
                            .overlay {
                                if searchResults.isEmpty {
                                    Text("Nessun risultato trovato.")
                                }
                            }
                    }
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
                                isShowingLoading = true
                                weatherForecast = try await APIHandler.shared.fetchWeatherForecast(latitude: viewModel.strCoordinates.latitude, longitude: viewModel.strCoordinates.longitude)
                                withAnimation {
                                        isShowingLoading = false
                                        hasFetched = true
                                }

                            } catch {
                                isShowingLoading = false
                                hasFetched = false

                                print(error.localizedDescription)
                            }
                        }
                }
                .navigationTitle("Meteo")

            }
        }
        .searchable(text: $searchText, prompt: "Cerca una città")

        
    }
}
    

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
