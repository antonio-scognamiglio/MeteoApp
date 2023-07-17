//
//  Coordinate-Extension.swift
//  Meteo-exercise
//
//  Created by Antonio Scognamiglio on 17/07/23.
//

import Foundation
import CoreLocation


extension CLLocationCoordinate2D: Equatable {
    public static func == (lhs: CLLocationCoordinate2D, rhs: CLLocationCoordinate2D) -> Bool {
        return lhs.latitude == rhs.latitude && lhs.longitude == rhs.longitude
    }
    
    
}
