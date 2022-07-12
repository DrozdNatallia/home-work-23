//
//  Constants.swift
//  home_work_23
//
//  Created by Natalia Drozd on 25.06.22.
//

import Foundation

struct Constants {

    static var baseURL = "https://api.openweathermap.org/"
    
    static var getCodingURL: String {
        return baseURL.appending("geo/1.0/direct")
    }
    
    static var weatherURL: String {
        return baseURL.appending("data/2.5/onecall")
    }
}
