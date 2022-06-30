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
            let newRequest = RealmQueryList()
            let provaider = RealmProvader()
            newRequest.latitude = lat
            newRequest.longitude = lon
            newRequest.time = time
            newRequest.currentWeather = provaider.getResult(nameObject: RealmCurrentWeather.self).last
            provaider.writeObjectToDatabase(name: newRequest)
        }
    
    func setCurrentWeatherQueryList(temp: Double, weather: String, time: Int){
        let newRequest = RealmCurrentWeather()
        newRequest.temp = temp
        newRequest.weatherDescription = weather
        newRequest.time = time
        RealmProvader().writeObjectToDatabase(name: newRequest)
    }
}
