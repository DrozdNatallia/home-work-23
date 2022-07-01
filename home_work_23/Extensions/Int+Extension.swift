//
//  Int + extension.swift
//  home_work_23
//
//  Created by Natalia Drozd on 30.06.22.
//

import Foundation
import UIKit

extension Int {
    func convertUnix(formattedType: FormattedType) -> String {
        let newDate = Date(timeIntervalSince1970: TimeInterval(self))
        let formatted = DateFormatter()
        formatted.dateFormat = formattedType.description
        let formattedTime = formatted.string(from: newDate)
        return formattedTime
    }
}
