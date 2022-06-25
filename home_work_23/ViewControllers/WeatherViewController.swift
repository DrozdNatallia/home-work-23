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
    
    @IBOutlet weak var sunrise: UILabel!
    @IBOutlet weak var sunset: UILabel!
    @IBOutlet weak var temp: UILabel!
    @IBOutlet weak var feelsLike: UILabel!
    @IBOutlet weak var pressure: UILabel!
    @IBOutlet weak var humidity: UILabel!
    @IBOutlet weak var clouds: UILabel!
    @IBOutlet weak var visibility: UILabel!
    @IBOutlet weak var windSpeed: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    
    var latitude: Double!
    var longitude: Double!
    var nameCity: String?
    override func viewDidLoad() {
        super.viewDidLoad()
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
                print("BAD1")
                print(error.localizedDescription)
            }
        }
    }
    
    private func getWeatherByCoordinates(city: InfoCity) {
        apiProvider.getWeatherForCityCoordinates(lat: city.lat, lon: city.lon) { result in
            switch result {
            case .success(let value):
               // updateUI(value.current)
                guard let current = value.current, let weather = current.weather, let icon = weather.first?.icon, let temp = current.temp else {return}
                self.temp.text = temp.description + "°"
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
        
