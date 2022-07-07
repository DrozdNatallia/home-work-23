//
//  InfoCity.swift
//  home_work_23
//
//  Created by Natalia Drozd on 22.06.22.
//

import Foundation

// MARK: - InfoElementElement
struct InfoCity: Codable {
    let name: String
    let localNames: [String: String]
    let lat, lon: Double
    let country: String
    let state: String?

    enum CodingKeys: String, CodingKey {
        case name
        case localNames = "local_names"
        case lat, lon, country, state
    }
}
