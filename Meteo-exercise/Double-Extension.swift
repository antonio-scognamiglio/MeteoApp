//
//  String-Extension.swift
//  Meteo-exercise
//
//  Created by Antonio Scognamiglio on 15/07/23.
//

import Foundation
extension Double {
    func convertToString() -> String {
        String(format: "%.2f", self)
    }
}
