//
//  SettingsViewController.swift
//  home_work_23
//
//  Created by Natalia Drozd on 16.07.22.
//

import UIKit

class SettingsViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    var arraySettings: [String]!
    override func viewDidLoad() {
        super.viewDidLoad()
        arraySettings = ["Choice weather conditional", "List all request"]
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
            cell.settingName.text = arraySettings[indexPath.row]
            return cell
        }
        return UITableViewCell()
    }
    
    
}
