//
//  WeekWeatherView.swift
//  Meteo-exercise
//
//  Created by Antonio Scognamiglio on 15/07/23.
//

import SwiftUI

struct WeekWeatherView: View {
    var dailyWeather: Daily
    var numberOfDays: Int {
        if let number = dailyWeather.time?.count {
            return number
        } else {
            // This should prevent any crashes, normally the api return at least 7 days, but 1 should be a safe number
            return 1
        }
    }
    var body: some View {
        
        ScrollView {
            ZStack {
                RoundedRectangle(cornerRadius: 15)
                    .foregroundColor(.cardColor2)
        
                VStack {
                    ForEach(0...numberOfDays - 1, id: \.self){ i in
                        HStack(spacing: 30) {
                            Group {
                                Text(dailyWeather.time?[i] ?? Daily.example.time![0])
                                Text("\(dailyWeather.stringTempMin[i])˚ - \(dailyWeather.stringTempMax[i])˚").fixedSize()
                                Image(systemName: getImage(for: dailyWeather.weathercode?[i] ?? 0))
                            }
                                .foregroundColor(Color(.white))
                                .font(.title3)
                                .fontWeight(.semibold)
                        }
    //                    .frame(maxWidth: .infinity, alignment: .leading)
                    }
                    Spacer()
                }
                .padding()
            }
            .frame(minHeight: UIScreen.main.bounds.height * 0.5)
        }
//        .padding()
        
    }
}

struct WeekWeatherView_Previews: PreviewProvider {
    static var previews: some View {
        WeekWeatherView(dailyWeather: Daily.example)
    }
}
