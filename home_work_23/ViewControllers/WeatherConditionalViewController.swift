//
//  WeatherConditionalViewController.swift
//  home_work_23
//
//  Created by Natalia Drozd on 16.07.22.
//

import UIKit

class WeatherConditionalViewController: UIViewController {
    var weatherConditional: [String]!
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        weatherConditional = ["thunderstorm", "rain", "snow"]
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.register(UINib(nibName: "WeatherConditionalCell", bundle: nil), forCellReuseIdentifier: WeatherConditionalCell.key)
        // Do any additional setup after loading the view.
    }
}

extension WeatherConditionalViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        weatherConditional.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: WeatherConditionalCell.key) as? WeatherConditionalCell {
            cell.nameWeatherConditional.text = weatherConditional[indexPath.row]
            return cell
        }
        return UITableViewCell()
    }
    
    
}
