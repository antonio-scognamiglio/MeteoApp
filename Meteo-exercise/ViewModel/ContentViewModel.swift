//
//  ContentViewModel.swift
//  Meteo-exercise
//
//  Created by Antonio Scognamiglio on 17/07/23.
//

import Foundation
import CoreLocation
import SwiftUI

final class ContentViewModel: NSObject, ObservableObject, CLLocationManagerDelegate {

//    @Published var coordinates: CLLocationCoordinate2D = CLLocationCoordinate2D(latitude: 41.9027835, longitude: 12.4963655)
    @Published var coordinates: CLLocationCoordinate2D = CLLocationCoordinate2D(latitude: 33.9027835, longitude: 18.4963655)
    @Published var isLoading = false
    var strCoordinates: (latitude: String, longitude: String) {
        let stringLat = String(format: "%.2f", coordinates.latitude)
        let stringLong = String(format: "%.2f", coordinates.longitude)
        return (stringLat, stringLong)
    }
    
    let locationManager = CLLocationManager()
    
    // We need to set our location manader delegate to ContenViewModel
    override init() {
        super.init()
        locationManager.delegate = self
    }
    
    func requestAllowOnceLocationPermission() {
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        
        withAnimation {
            locationManager.requestLocation()
        }

    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        guard let latestLocation = locations.first else {
            // show an error
            return
        }
        
        Task { @MainActor in
            withAnimation {
                self.coordinates = latestLocation.coordinate
            }
            
            print(coordinates)
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error.localizedDescription)
    }
    
}
