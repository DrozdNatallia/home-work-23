//
//  RealmListController + extension.swift
//  home_work_23
//
//  Created by Natalia Drozd on 30.06.22.
//

import Foundation
import UIKit
import RealmSwift


extension RealmListController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return provaider.getResult(nameObject: RealmQueryList.self).count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: ListRequestTableCell.key) as? ListRequestTableCell {
            let info = provaider.getResult(nameObject: RealmQueryList.self)[indexPath.row]
            guard let currentWeather = info.currentWeather else {return cell}
            cell.longitude.text = info.longitude.description
            cell.latitude.text = info.latitude.description
            cell.time.text = info.time.convertUnix(formattedType: .fullTime)
            cell.temp.text = currentWeather.temp.description
            cell.weatherDescription.text = currentWeather.weatherDescription
            cell.isCurrentWeather.text = NSLocalizedString(currentWeather.isCurrentWeather.description, comment: "")
            return cell
        }
        return UITableViewCell()
    }
    
    
}
