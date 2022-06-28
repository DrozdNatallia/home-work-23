//
//  DailyWeatherCell.swift
//  home_work_23
//
//  Created by Natalia Drozd on 28.06.22.
//

import UIKit

class DailyWeatherCell: UITableViewCell {
    @IBOutlet weak var minTemp: UILabel!
    @IBOutlet weak var maxTemp: UILabel!
    @IBOutlet weak var icon: UIImageView!
    @IBOutlet weak var days: UILabel!
    static let key = "DailyWeatherCell"
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
