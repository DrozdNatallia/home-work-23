//
//  CurrentWeatherCell.swift
//  home_work_23
//
//  Created by Natalia Drozd on 28.06.22.
//

import UIKit

class CurrentWeatherCell: UITableViewCell {
    @IBOutlet weak var nameCity: UILabel!
    @IBOutlet weak var currentTemp: UILabel!
    @IBOutlet weak var currentClouds: UILabel!
    
    @IBOutlet weak var currentMaxMinTemp: UILabel!
    static let key = "CurrentWeatherCell"
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
