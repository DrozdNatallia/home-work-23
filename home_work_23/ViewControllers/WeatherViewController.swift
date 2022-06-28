//
//  ViewController.swift
//  home_work_23
//
//  Created by Natalia Drozd on 19.06.22.
//

import UIKit
import Alamofire

class WeatherViewController: UIViewController {
    private var apiProvider: RestAPIProviderProtocol!
    var nameCity: String!
    @IBOutlet weak var tableView: UITableView!
    
    var currentClouds: String!
    var temp: Double!
    var weatherImage: UIImage!
    
    var dailyMaxTempArray: [Double] = []
    var dailyArrayDt: [String] = []
    var dailyArrayMinTemp: [Double] = []
    var dailyImageArray: [UIImage] = []
    
    var hourlyArrayTemp: [Double] = []
    var hourlyArrayDt: [String] = []
    var hourlyArrayImage: [UIImage] = []

    enum ContentType: Int {
        case current = 0
        case hourly
        case daily
  
        
        var description: String {
            switch self {
            case.current:
                return "Current weather"
            case.hourly:
                return "Houly weather"
            case.daily:
                return "Daily weather"
            }
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "WeatherCell", bundle: nil), forCellReuseIdentifier: WeatherCell.key)
        apiProvider = AlamofireProvaider()
        getCoordinatesByName()
    }
    
    fileprivate func getCoordinatesByName() {
        apiProvider.getCoordinatesByName(name: "London") { [weak self] result in
            guard let self = self else {return}
            switch result {
            case .success(let value):
                if let city = value.first {
                    self.getWeatherByCoordinates(city: city)
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func convertUnix(unixTime: Int) -> String {
        let newDate = Date(timeIntervalSince1970: TimeInterval(unixTime))
        let formatted = DateFormatter()
        formatted.dateStyle = .none
        formatted.timeStyle = .medium
        let formattedTime = formatted.string(from: newDate)
        return formattedTime
    }
    
    private func getWeatherByCoordinates(city: InfoCity) {
        apiProvider.getWeatherForCityCoordinates(lat: city.lat, lon: city.lon) { [weak self] result in
            guard let self = self else {return}
            switch result {
            case .success(let value):
                guard let current = value.current, let weather = current.weather, let temp = current.temp, let clouds = weather.first?.description else {return}
                self.temp = temp
                self.currentClouds = clouds
                
                // MARK: Hourly
                guard let hourly = value.hourly else {return }
                for item in hourly {
                    guard let hourlyTemp = item.temp, let hourlyDt = item.dt, let weather = item.weather, let icon = weather.first?.icon else {return}
                    if let url = URL(string: "https://openweathermap.org/img/wn/\(icon)@2x.png") {
                        do {
                            let data = try Data(contentsOf: url)
                            self.hourlyArrayImage.append(UIImage(data: data)!)
                        } catch _ {
                            print("error")
                        }
                    }
                    self.hourlyArrayDt.append(self.convertUnix(unixTime: hourlyDt, isDate: false))
                    self.hourlyArrayTemp.append(hourlyTemp)
                }
                
                // MARK: DAILY
                guard let daily = value.daily else {return }
                
                for item in daily {
                    guard let temp = item.temp, let maxTemp = temp.max, let minTemp = temp.min, let days = item.dt, let weather = item.weather, let icon = weather.first?.icon else {return}
                    
                    if let url = URL(string: "https://openweathermap.org/img/wn/\(icon)@2x.png") {
                        do {
                            let data = try Data(contentsOf: url)
                            self.dailyImageArray.append(UIImage(data: data)!)
                        } catch _ {
                            print("error")
                        }
                    }
                    self.dailyMaxTempArray.append(maxTemp)
                    self.dailyArrayMinTemp.append(minTemp)
                    self.dailyArrayDt.append(self.convertUnix(unixTime: days, isDate: true))
                    
                }
                self.tableView.reloadData()
            case .failure(let error):
                print(error)
            }
            
        }
    }
}
        
