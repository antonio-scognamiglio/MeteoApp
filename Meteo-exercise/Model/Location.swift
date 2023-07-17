//
//  Location.swift
//  Meteo-exercise
//
//  Created by Antonio Scognamiglio on 17/07/23.
//

import Foundation

struct Location: Codable {
    let istat: String?
    let comune: String?
    let longitude: String?
    let latitude: String?
    
    enum CodingKeys: String, CodingKey {
        case istat
        case comune
        case longitude = "lng"
        case latitude = "lat"
    }
}
