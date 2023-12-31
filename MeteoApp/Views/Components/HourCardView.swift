//
//  HourCardView.swift
//  Meteo-exercise
//
//  Created by Antonio Scognamiglio on 15/07/23.
//

import SwiftUI

struct HourCardView: View {
    let hour: String
    let weatherCode: Int
    let temperature: String
    
    var strCurrentHour: String {
        let currentHour = Calendar.current.dateComponents([.hour], from: Date.now).hour
        return String(currentHour!)
    }
    
    var body: some View {
            ZStack {
                RoundedRectangle(cornerRadius: 15)
                    .foregroundColor(.cardColor2)
                VStack(spacing: 7) {
                    Text(formatHour(from: hour) == strCurrentHour ? "Adesso" : formatHour(from: hour))
                        .foregroundColor(Color(.white))
                        .font(.headline)
                    Image(systemName: getImage(for: weatherCode))
                        .font(.system(size: 28))
                        .foregroundColor(.yellow)
                    Text("\(temperature)˚")
                        .foregroundColor(Color(.white))
                        .font(.headline)
                }
            }
            .frame(width: UIScreen.main.bounds.width * 0.25, height: UIScreen.main.bounds.height * 0.12)
    }
}

struct HourCardView_Previews: PreviewProvider {
    static var previews: some View {
        HourCardView(hour: "2023-07-14T10:00", weatherCode: 0, temperature: "30")
    }
}
