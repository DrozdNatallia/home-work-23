//
//  WeatherViewController + extension.swift
//  home_work_23
//
//  Created by Natalia Drozd on 26.06.22.
//

import Foundation
import UIKit

extension WeatherViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        3
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let key = ContentType(rawValue: indexPath.section)
        if let cell = tableView.dequeueReusableCell(withIdentifier: WeatherCell.key) as? WeatherCell {
            switch key {
            case .current:
                guard let temp = temp, let sunset = sunset, let sunrise = sunrise, let humidity = humidity, let windSpeed = windSpeed, let image = weatherImage else {return cell}
                cell.windSpeed.text = "Wind speed: " + windSpeed.description + "m/s"
                cell.sunset.text = "Sunset: " + sunset
                cell.sunrise.text = "Sunrise: " + sunrise
                cell.humidity.text = "Humidity: " + humidity.description + "%"
                cell.temp.text = "Temp: " + temp.description + "°"
                cell.weatherImageView.image = image
                
            case.daily:
                guard let temp = dailyTemp, let sunset = dailySunset, let sunrise = dailySunrise, let humidity = dailyHumidity, let windSpeed = dailyWindSpeed, let image = dailyWeatherImage else {return cell}
                cell.windSpeed.text = "Wind speed: " + windSpeed.description + "m/s"
                cell.sunset.text = "Sunset: " + sunset
                cell.sunrise.text = "Sunrise: " + sunrise
                cell.humidity.text = "Humidity: " + humidity.description + "%"
                cell.temp.text = "Temp: " + temp.description + "°"
                cell.weatherImageView.image = image
            default:
                guard let hourlyHumidity = hourlyHumidity, let hourlyMaxTemp = hourlyTemp, let hourlyUvi = hourlyUvi, let hourlyPressure = hourlyPressure, let hourlyWindSpeed = hourlyWindSpeed, let image = hourlyWeatherImage else { return cell}
                cell.windSpeed.text = "Wind speed: " + hourlyWindSpeed.description + "m/s"
                cell.sunset.text = "Pressure: " + hourlyPressure.description
                cell.sunrise.text = "Uvi: " + hourlyUvi.description
                cell.humidity.text = "Humidity: " + hourlyHumidity.description + "%"
                cell.temp.text = "Temp: " + hourlyMaxTemp.description + "°"
                cell.weatherImageView.image = image
                
            }
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let key = ContentType(rawValue: section)
        switch key {
        case .daily:
            return ContentType.daily.description
        case .hourly:
            return ContentType.hourly.description
        case.current:
            return ContentType.current.description
        default:
            return ""
        }
    }
    
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        30
    }
}
