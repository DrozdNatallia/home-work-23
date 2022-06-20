//
//  ViewController.swift
//  home_work_23
//
//  Created by Natalia Drozd on 19.06.22.
//

import UIKit

class ViewController: UIViewController {
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
        if let url = URL(string: "https://api.openweathermap.org/data/2.5/weather?q=\(nameCity)&appid=\(key)") {
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

