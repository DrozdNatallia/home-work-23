//
//  SettingsViewController.swift
//  home_work_23
//
//  Created by Natalia Drozd on 16.07.22.
//

import UIKit

class SettingsViewController: UIViewController {
    enum typeSettings: Int {
        case conditionalWeatherlistRequest = 0
        case listRequest
    }
    @IBOutlet weak var tableView: UITableView!
    var arraySettings: [String]!
    override func viewDidLoad() {
        super.viewDidLoad()
        arraySettings = ["Choice weather conditional", "History request"]
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.register(UINib(nibName: "SettingsCells", bundle: nil), forCellReuseIdentifier: SettingsCells.key)
        // Do any additional setup after loading the view.
    }

}

extension SettingsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        arraySettings.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: SettingsCells.key) as? SettingsCells {
            cell.settingName.text = NSLocalizedString(arraySettings[indexPath.row], comment: "")
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch typeSettings(rawValue: indexPath.row) {
        case .listRequest:
            if let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "RealmListController") as? RealmListController {
                
                present(vc, animated: true)
            }
            
        default:
            if let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "WeatherConditionalViewController") as? WeatherConditionalViewController {
              
                present(vc, animated: true)
                
            }
            
        }
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        60
    }
    
}
