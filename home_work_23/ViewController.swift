//
//  ViewController.swift
//  home_work_23
//
//  Created by Natalia Drozd on 19.06.22.
//

import UIKit

class ViewController: UIViewController {
    
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
    var key: String? {
        get {
            Bundle.main.infoDictionary?["API_KEY"] as? String
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // адрес сервера
        nameCity = "London"
        guard let nameCity = nameCity, let key = key else {
            return
        }
        // запрос для получения координат
        if let url = URL(string: "https://api.openweathermap.org/geo/1.0/direct?q=\(nameCity)&limit=2&appid=\(key)") {
            // запрос
            var urlRequest = URLRequest(url: url)
            // тип запроса
            urlRequest.httpMethod = "GET"
            //таск для непосредственно запроса на сервер
            let task = URLSession.shared.dataTask(with: urlRequest) { data, response, error in
                if let response = response {
                    print(response)
                }
                if let data = data {
                    let info = try! JSONDecoder().decode([InfoCity].self, from: data)
                    
// MARK: Запрос на получение данных о погоде
                        // координаты получаем из предыдушего запроса
                    if let url = URL(string: "https://api.openweathermap.org/data/2.5/onecall?lat=\(info[0].lat)&lon=\(info[0].lon)&exclude=minutely,alerts&appid=\(key)") {
                        var urlRequest = URLRequest(url: url)
                        urlRequest.httpMethod = "GET"
                        let task = URLSession.shared.dataTask(with: urlRequest) { data, response, error in
                            if let response = response {
                                print(response)
                            }
                            if let data = data {
                                let currentWeather = try! JSONDecoder().decode(Weather.self, from: data)
                                // присваиваем значения лэйблам
                                DispatchQueue.main.async {
                                    self.clouds.text = "\(currentWeather.current.clouds)"
                                    self.sunset.text = "\(currentWeather.current.sunset ?? 0)"
                                    self.sunrise.text = "\(currentWeather.current.sunrise ?? 0)"
                                    self.visibility.text = "\(currentWeather.current.visibility)"
                                    self.humidity.text = "\(currentWeather.current.humidity)"
                                    self.temp.text = "\(currentWeather.current.temp)"
                                    self.pressure.text = "\(currentWeather.current.pressure)"
                                    self.windSpeed.text = "\(currentWeather.current.windSpeed)"
                                    self.feelsLike.text = "\(currentWeather.current.feelsLike)"
                                    // присваиваем значения для иконки
                                    let icon = currentWeather.current.weather[0].icon.rawValue
                                    // добавляем иконку по URL
                                    if let url = URL(string: "https://openweathermap.org/img/wn/\(icon)@2x.png") {
                                        do {
                                            let data = try Data(contentsOf: url)
                                            self.imageView.image = UIImage(data: data)
                                        } catch _ {
                                            print("error")
                                        }
                                    }
                                }
                            }
                            if let error = error {
                                print(error)
                            }
                        }
                        task.resume()
                    }
                }
                if let error = error {
                    print(error)
                }
            }
            print("Requesting...")
            //запускаем запрос на выполнение
            task.resume()
        }
    }
}

