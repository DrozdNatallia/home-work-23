//
//  WeatherConditionalViewController+extension.swift
//  home_work_23
//
//  Created by Natalia Drozd on 18.07.22.
//

import Foundation
import UIKit

extension WeatherConditionalViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        weatherConditional.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: WeatherConditionalCell.key) as? WeatherConditionalCell {
            cell.nameWeatherConditional.text = NSLocalizedString(weatherConditional[indexPath.row], comment: "")
            switch conditionalType(rawValue: indexPath.row) {
            case .thuderstorm:
                cell.icon.image = UIImage(systemName: defaults.bool(forKey: "thunderstorm") ? "square.fill" : "square")
            case .rain:
                cell.icon.image = UIImage(systemName: defaults.bool(forKey: "rain") ? "square.fill" : "square")
            default:
                cell.icon.image = UIImage(systemName: defaults.bool(forKey: "snow") ? "square.fill" : "square")
            }
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        switch conditionalType(rawValue: indexPath.row){
        case .thuderstorm:
            let value = defaults.bool(forKey: "thunderstorm") ? false : true
            UserDefaults.standard.set(value, forKey: "thunderstorm")
        case.rain:
            let value = defaults.bool(forKey: "rain") ? false : true
            UserDefaults.standard.set(value, forKey: "rain")
        default:
            let value = defaults.bool(forKey: "snow") ? false : true
            UserDefaults.standard.set(value, forKey: "snow")
        }
        tableView.reloadData()
        notificationCenter.removeAllPendingNotificationRequests()
    }
}

