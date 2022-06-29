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
    
    func convertUnix(unixTime: Int, formattedType: FormattedType) -> String {
        let newDate = Date(timeIntervalSince1970: TimeInterval(unixTime))
        let formatted = DateFormatter()
        switch formattedType {
        case .day:
            formatted.dateFormat = "EEE"
        case .hour:
            formatted.dateFormat = "hh"
        case .fullTime:
            formatted.dateFormat = "dd-MM-yy HH:mm:ss"
        }
        let formattedTime = formatted.string(from: newDate)
        return formattedTime
    }
    
        func setQueryList(lat: Double, lon: Double, time: Int) {
            let realm = try! Realm()
            let newRequest = RealmQueryList()
            newRequest.latitude = lat
            newRequest.longitude = lon
            newRequest.time = time
            let o = realm.objects(RealmCurrentWeather.self).last
            newRequest.currentWeather = o
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

