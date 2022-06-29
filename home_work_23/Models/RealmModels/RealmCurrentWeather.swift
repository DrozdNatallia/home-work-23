//
//  RealmCurrentWeather.swift
//  home_work_23
//
//  Created by Natalia Drozd on 30.06.22.
//

import Foundation
import RealmSwift

class RealmCurrentWeather: Object {
    @objc dynamic var temp: Double = 0.0
    @objc dynamic var weatherDescription: String = ""
    @objc dynamic var time: Int = 0
}
