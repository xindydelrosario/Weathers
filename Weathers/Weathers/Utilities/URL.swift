//
//  URLExtensions.swift
//  Weathers
//
//  Created by xindy.del.rosario on 1/31/23.
//

import Foundation
import CoreLocation

extension URL {
    
    static func getForecastByCity(_ city: String) -> URL? {
        return URL(string: "https://api.openweathermap.org/data/2.5/forecast?q=\(city)&appid=953add67a12dc794e7a69cde0e4a01c6&units=metric")
    }
    
    static func getForecastByLocation(latitude: CLLocationDegrees, longitude: CLLocationDegrees) -> URL? {
        return URL(string: "https://api.openweathermap.org/data/2.5/forecast?lat=\(latitude)&lon=\(longitude)&appid=953add67a12dc794e7a69cde0e4a01c6&units=metric")
    }
    
    static func weatherIcon(icon: String) -> String {
        return "https://openweathermap.org/img/w/\(icon).png"
    }
    
}
