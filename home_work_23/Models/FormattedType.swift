//
//  FormattedType.swift
//  home_work_23
//
//  Created by Natalia Drozd on 30.06.22.
//

import Foundation

enum FormattedType {
    case day
    case hour
    case fullTime
    
    var description: String {
        switch self {
         case .day:
             return "EEE"
         case .hour:
             return "hh"
         case .fullTime:
             return "dd-MM-yy HH:mm:ss"
         }
    }
}
