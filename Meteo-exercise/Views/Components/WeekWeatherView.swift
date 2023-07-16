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
        
//            ZStack {
                
                        
//                        ScrollView {
        VStack {
            ForEach(0...numberOfDays - 1, id: \.self){ i in
                                    HStack {
                                        Group {
                                            if i != 0 {
                                                Text(formatWeekDay(from: dailyWeather.time?[i]).capitalized)
                                                    .frame(width: UIScreen.main.bounds.width * 0.25, alignment: .leading)
                                            } else {
                                                Text("Oggi")
                                                    .frame(width: UIScreen.main.bounds.width * 0.25, alignment: .leading)
                                            }
                                            Spacer()
                                            Text("\(dailyWeather.stringTempMin[i])˚ - \(dailyWeather.stringTempMax[i])˚").fixedSize()
                                            .frame(width: UIScreen.main.bounds.width * 0.25)
                                            
                                            Spacer()
                                            
                                            Image(systemName: getImage(for: dailyWeather.weathercode?[i] ?? 0))
                                        }
                                            .foregroundColor(Color(.white))
                                            .font(.title3)
                                            .fontWeight(.semibold)
                                    }
                                    .padding(.horizontal)
                                    .padding(.vertical, 10)
                if i != numberOfDays - 1 {
                    Divider()
                }
            }
        }
        .padding()
        .background {
            RoundedRectangle(cornerRadius: 15)
                .foregroundColor(.cardColor2)
        }
        
    }
}

struct WeekWeatherView_Previews: PreviewProvider {
    static var previews: some View {
        WeekWeatherView(dailyWeather: Daily.example)
    }
}
