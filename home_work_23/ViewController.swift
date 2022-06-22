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
                    let weather = try! JSONDecoder().decode(Weather.self, from: data)
                    print(weather)
                    // let data = try! JSONEncoder().encode(weather)
                    // print(data)
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

