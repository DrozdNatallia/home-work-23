//
//  UiViewController + extension.swift
//  home_work_23
//
//  Created by Natalia Drozd on 30.06.22.
//

import Foundation
import UIKit
import RealmSwift


extension UIViewController {
    
        func setQueryList(lat: Double, lon: Double, time: Int) {
            let realm = try! Realm()
            let newRequest = RealmQueryList()
            newRequest.latitude = lat
            newRequest.longitude = lon
            newRequest.time = time
            newRequest.currentWeather = realm.objects(RealmCurrentWeather.self).last
             try! realm.write {
                 realm.add(newRequest)
             }
            print(realm.configuration.fileURL)
        }
    
    func setCurrentWeatherQueryList(temp: Double, weather: String, time: Int){
        let newRequest = RealmCurrentWeather()
        newRequest.temp = temp
        newRequest.weatherDescription = weather
        newRequest.time = time
        let realm = try! Realm()
        try! realm.write {
            realm.add(newRequest)
        }
        
    }
}
