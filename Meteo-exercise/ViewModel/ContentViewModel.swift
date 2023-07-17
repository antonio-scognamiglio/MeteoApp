//
//  ContentViewModel.swift
//  Meteo-exercise
//
//  Created by Antonio Scognamiglio on 17/07/23.
//

import Foundation
import CoreLocation

final class ContentViewModel: NSObject, ObservableObject, CLLocationManagerDelegate {

    @Published var coordinates: CLLocationCoordinate2D = CLLocationCoordinate2D(latitude: 41.9027835, longitude: 12.4963655)
    
    
}
