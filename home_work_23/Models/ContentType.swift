//
//  ContentType.swift
//  home_work_23
//
//  Created by Natalia Drozd on 12.07.22.
//

import Foundation
import UIKit

enum ContentType: Int {
    case current = 0
    case hourly
    case daily
    var description: String {
        switch self {
        case .current:
            return "Current weather"
        case .hourly:
            return "Hourly weather"
        case .daily:
            return "Daily weather"
        }
    }
}
