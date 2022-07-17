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
    enum conditionalType: Int {
        case thuderstorm = 0
        case rain
        case snow
    }
    var defaults = UserDefaults()
    override func viewDidLoad() {
        super.viewDidLoad()
        weatherConditional = ["thunderstorm", "rain", "snow"]
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.register(UINib(nibName: "WeatherConditionalCell", bundle: nil), forCellReuseIdentifier: WeatherConditionalCell.key)
    }
}

extension WeatherConditionalViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        weatherConditional.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: WeatherConditionalCell.key) as? WeatherConditionalCell {
            cell.nameWeatherConditional.text = weatherConditional[indexPath.row]
            switch conditionalType(rawValue: indexPath.row) {
            case .thuderstorm:
                if defaults.bool(forKey: "thunderstorm") {
                    cell.icon.image = UIImage(systemName: "square.fill")
                    } else {
                    cell.icon.image = UIImage(systemName: "square") }
            case .rain:
                if defaults.bool(forKey: "rain") {
                    cell.icon.image = UIImage(systemName: "square.fill")
                    } else {
                    cell.icon.image = UIImage(systemName: "square") }
            default:
                if defaults.bool(forKey: "snow") {
                    cell.icon.image = UIImage(systemName: "square.fill")
                    } else {
                    cell.icon.image = UIImage(systemName: "square") }
            }
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        switch conditionalType(rawValue: indexPath.row){
        case .thuderstorm:
            if defaults.bool(forKey: "thunderstorm") {
            UserDefaults.standard.set(false, forKey: "thunderstorm")
            } else {
                UserDefaults.standard.set(true, forKey: "thunderstorm")}
            tableView.reloadData()
        case.rain:
            if defaults.bool(forKey: "rain") {
            UserDefaults.standard.set(false, forKey: "rain")
            } else {
                UserDefaults.standard.set(true, forKey: "rain")}
            tableView.reloadData()
        default:
            if defaults.bool(forKey: "snow") {
            UserDefaults.standard.set(false, forKey: "snow")
            } else {
                UserDefaults.standard.set(true, forKey: "snow")}
            tableView.reloadData()
        }
    }
}

