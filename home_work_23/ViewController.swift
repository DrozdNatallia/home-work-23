//
//  ViewController.swift
//  home_work_23
//
//  Created by Natalia Drozd on 19.06.22.
//

import UIKit

class ViewController: UIViewController {
    var valueKey: String?
    override func viewDidLoad() {
        super.viewDidLoad()
        // адрес сервера
        let appDelegate = UIApplication.shared.delegate as? AppDelegate
        if let appDelegate = appDelegate {
            valueKey = appDelegate.valueApi
        }
        guard let valueKey = valueKey else {
            return
        }
        if let url = URL(string: "https://api.openweathermap.org/data/2.5/weather?q=London&appid=\(valueKey)") {
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

