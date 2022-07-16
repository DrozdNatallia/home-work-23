//
//  WeatherViewController + extension.swift
//  home_work_23
//
//  Created by Natalia Drozd on 26.06.22.
//

import Foundation
import UIKit
import CoreLocation

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
                cell.currentClouds.text = NSLocalizedString(clouds, comment: "")
                cell.currentMaxMinTemp.text = "\(NSLocalizedString("Min", comment: "")): \(Int(minTemp))°, \(NSLocalizedString("Max", comment: "")): \(Int(maxTemp))°"
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
                cell.days.text = NSLocalizedString(dailyArrayDt[indexPath.row], comment: "")
                cell.minTemp.text = "\(NSLocalizedString("Min", comment: "")): \(Int(dailyArrayMinTemp[indexPath.row]))°"
                cell.maxTemp.text = "\(NSLocalizedString("Max", comment: "")): \(Int(dailyMaxTempArray[indexPath.row]))°"
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
            return NSLocalizedString(ContentType.daily.description, comment: "")
        case .hourly:
            return NSLocalizedString(ContentType.hourly.description, comment: "")
        case.current:
            return NSLocalizedString(ContentType.current.description, comment: "")
        default:
            return ""
        }
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        30
    }
}
// MARK: CLLocation
extension WeatherViewController: CLLocationManagerDelegate {
   
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        if manager.authorizationStatus == .authorizedAlways || manager.authorizationStatus == .authorizedWhenInUse {
            coreManager.startUpdatingLocation()
            
        } else if manager.authorizationStatus == .restricted || manager.authorizationStatus == .denied {
            locationButton.isEnabled = false
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let userLocation = locations.last! as CLLocation
        self.currentCoordinate = userLocation.coordinate
        let geocoder = CLGeocoder()
        geocoder.reverseGeocodeLocation(userLocation) { [self] (placemarks, error) in
                if let error = error {
                    print("Unable to Reverse Geocode Location (\(error))")
                } else {
                    if let placemarks = placemarks, let placemark = placemarks.first, let locality = placemark.locality {
                        self.currentName = locality
                        if self.selectionMode == .navigation {
                        self.nameCity = self.currentName
                        }
                    }
                }
            }
        
        coreManager.stopUpdatingLocation()
        if selectionMode == .navigation {
            getWeatherByLocation()
        }
        
    }
}
// MARK: TextField
extension WeatherViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard CharacterSet.letters.isSuperset(of: CharacterSet(charactersIn: string)) || CharacterSet.whitespaces.isSuperset(of: CharacterSet(charactersIn: string)) || CharacterSet(charactersIn: "-").isSuperset(of: CharacterSet(charactersIn: string)) else {
            return false
        }
        return true

    }
}
