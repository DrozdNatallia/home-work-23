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
        apiProvider.getWeatherForCityCoordinates(lat: city.lat, lon: city.lon) { result in
            switch result {
            case .success(let value):
                guard let current = value.current, let weather = current.weather, let icon = weather.first?.icon, let temp = current.temp, var sunrise = current.sunrise, var sunset = current.sunset, let windSpeed = current.windSpeed, let feelsLike = current.feelsLike, let clouds = current.clouds, let humidity = current.humidity, let pressure = current.pressure, let visibility = current.visibility else {return}
                self.temp.text = temp.description + "°"
                self.sunrise.text = self.convertUnix(unixTime: &sunrise)
                self.sunset.text = self.convertUnix(unixTime: &sunset)
                self.windSpeed.text = windSpeed.description + "m/s"
                self.feelsLike.text = feelsLike.description + "°"
                self.humidity.text = humidity.description + "%"
                self.pressure.text = pressure.description + "hPa"
                self.visibility.text = visibility.description + "km"
                self.clouds.text = clouds.description
                if let url = URL(string: "https://openweathermap.org/img/wn/\(icon)@2x.png") {
                    do {
                        let data = try Data(contentsOf: url)
                        self.imageView.image = UIImage(data: data)
                    } catch _ {
                        print("error")
                    }
                }
            case .failure(let error):
                print(error)
            }
            
        }
    }
}
        
