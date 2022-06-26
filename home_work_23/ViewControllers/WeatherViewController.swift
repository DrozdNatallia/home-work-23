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
    
    @IBOutlet weak var tableView: UITableView!
    var sunrise: String!
    var sunset: String!
    var temp: Double!
    var humidity: Int!
    var windSpeed: Double!
    var weatherImage: UIImage!
    
    var dailySunrise: String!
    var dailySunset: String!
    var dailyTemp: Double!
    var dailyHumidity: Int!
    var dailyWindSpeed: Double!
    var dailyWeatherImage: UIImage!
    
    var hourlyUvi: Double!
    var hourlyPressure: Int!
    var hourlyTemp: Double!
    var hourlyHumidity: Int!
    var hourlyWindSpeed: Double!
    var hourlyWeatherImage: UIImage!
    
    struct Content {
        var type: ContentType
        var content: [String]
    }
    
    enum ContentType: Int {
        case current = 0
        case daily
        case hourly
        
        var description: String {
            switch self {
            case.current:
                return "Current weather"
            case.daily:
                return "Daily weather"
            case.hourly:
                return "Hourly weather"
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
    
    func convertUnix(unixTime: inout Int) -> String {
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
                guard let current = value.current, let weather = current.weather, let icon = weather.first?.icon, let temp = current.temp, let sunrise = current.sunrise, let sunset = current.sunset, let windSpeed = current.windSpeed, let humidity = current.humidity else {return}
                self.temp = temp
                self.sunrise = self.convertUnix(unixTime: sunrise)
                self.sunset = self.convertUnix(unixTime: sunset)
                self.windSpeed = windSpeed
                self.humidity = humidity
                if let url = URL(string: "https://openweathermap.org/img/wn/\(icon)@2x.png") {
                    do {
                        let data = try Data(contentsOf: url)
                        self.weatherImage = UIImage(data: data)
                    } catch _ {
                        print("error")
                    }
                }
                
                // MARK: Hourly
                guard let hourly = value.daily, let weather = hourly.first?.weather, let icon = weather.first?.icon, let hourlyHumidity = hourly.first?.humidity, let hourlyMaxTemp = hourly.first?.temp?.max, let hourlyPressure = hourly.first?.pressure, let hourlyUvi = hourly.first?.uvi, let hourlyWindSpeed = hourly.first?.windSpeed else {return }
                self.hourlyTemp = hourlyMaxTemp
                self.hourlyHumidity = hourlyHumidity
                self.hourlyPressure = hourlyPressure
                self.hourlyUvi = hourlyUvi
                self.hourlyWindSpeed = hourlyWindSpeed
                if let url = URL(string: "https://openweathermap.org/img/wn/\(icon)@2x.png") {
                    do {
                        let data = try Data(contentsOf: url)
                        self.hourlyWeatherImage = UIImage(data: data)
                    } catch _ {
                        print("error")
                    }
                }
                
                // MARK: DAILY
                guard let daily = value.daily, let weather = daily.first?.weather, let icon = weather.first?.icon, let temp = daily.first?.temp, let maxTemp = temp.max, let dailyHumidity = daily.first?.humidity, var dailySunrise = daily.first?.sunrise, var dailySunset = daily.first?.sunset, let dailyWindSpeed = daily.first?.windSpeed else {return }
                self.dailyTemp = maxTemp
                self.dailyHumidity = dailyHumidity
                self.dailySunrise = self.convertUnix(unixTime: &dailySunrise)
                self.dailySunset = self.convertUnix(unixTime: &dailySunset)
                self.dailyWindSpeed = dailyWindSpeed
                if let url = URL(string: "https://openweathermap.org/img/wn/\(icon)@2x.png") {
                    do {
                        let data = try Data(contentsOf: url)
                        self.dailyWeatherImage = UIImage(data: data)
                    } catch _ {
                        print("error")
                    }
                }
                self.tableView.reloadData()
            case .failure(let error):
                print(error)
            }
            
        }
    }
}
        
