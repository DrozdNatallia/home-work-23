//
//  RealmProvaider.swift
//  home_work_23
//
//  Created by Natalia Drozd on 30.06.22.
//

import Foundation
import RealmSwift
import UIKit

class RealmProvader: RealmProviderProtocol {
    private let realm = try! Realm()
    
    func writeObjectToDatabase(name: Object) {
        try! realm.write {
            realm.add(name)
        }
    }
    func getResult<T: RealmFetchable>(nameObject: T.Type) -> Results<T> {
        realm.objects(nameObject.self)
    }
    
    func setQueryList(lat: Double, lon: Double, time: Int) {
        let newRequest = RealmQueryList()
        newRequest.latitude = lat
        newRequest.longitude = lon
        newRequest.time = time
        newRequest.currentWeather = getResult(nameObject: RealmCurrentWeather.self).last
        writeObjectToDatabase(name: newRequest)
    }
    
    func setCurrentWeatherQueryList(temp: Double, weather: String, time: Int, isCurrentWeather: Bool){
        let newRequest = RealmCurrentWeather()
        newRequest.temp = temp
        newRequest.weatherDescription = weather
        newRequest.time = time
        newRequest.isCurrentWeather = isCurrentWeather
        writeObjectToDatabase(name: newRequest)
    }
}
