//
//  queryList.swift
//  home_work_23
//
//  Created by Natalia Drozd on 29.06.22.
//

import Foundation
import RealmSwift

class RealmQueryList: Object {
    @objc dynamic var latitude: Double = 0.0
    @objc dynamic var longitude: Double = 0.0
    @objc dynamic var time: Int = 0
    @objc dynamic var currentWeather: RealmCurrentWeather?
}
