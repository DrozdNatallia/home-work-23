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
        let key = ContentType(rawValue: section)
        switch key {
        case .daily:
            return dailyArrayDt.count
        default:
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let key = ContentType(rawValue: indexPath.section)
        switch key {
        case .current:
            if let cell = tableView.dequeueReusableCell(withIdentifier: CurrentWeatherCell.key) as? CurrentWeatherCell {
                guard let nameCity = nameCity, let temp = temp, let clouds = currentClouds, let maxTemp = dailyMaxTempArray.max(), let minTemp = dailyMaxTempArray.min() else {return cell}
                cell.layer.backgroundColor = UIColor.clear.cgColor
                cell.backgroundColor = .clear
                    cell.nameCity.text = nameCity
                    cell.currentTemp.text = "\(Int(temp))°"
                    cell.currentClouds.text = clouds
                cell.currentMaxMinTemp.text = "Min: \(Int(minTemp))°, Max: \(Int(maxTemp))°"
                return cell
            }
        case .hourly:
            
            if let cell = tableView.dequeueReusableCell(withIdentifier: "HourlyWeatherCell", for: indexPath) as? HourlyWeatherCell {
                cell.layer.backgroundColor = UIColor.clear.cgColor
                cell.backgroundColor = .clear
                cell.tempArray = hourlyArrayTemp
                cell.dtArray = hourlyArrayDt
                cell.imageArray = hourlyArrayImage
                cell.collectionView.reloadData()
               return cell
            }
        default:
            if let cell = tableView.dequeueReusableCell(withIdentifier: DailyWeatherCell.key) as? DailyWeatherCell {
                cell.contentView.backgroundColor = UIColor.clear
                cell.layer.backgroundColor = UIColor.clear.cgColor
                cell.backgroundColor = .clear
                cell.days.text = "\(dailyArrayDt[indexPath.row])"
                cell.minTemp.text = "Min: \(Int(dailyArrayMinTemp[indexPath.row]))°"
                cell.maxTemp.text = "Max: \(Int(dailyMaxTempArray[indexPath.row]))°"
                cell.icon.image = dailyImageArray[indexPath.row]
                return cell
            }
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
