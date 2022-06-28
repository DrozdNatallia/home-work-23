//
//  HourlyWeatherCollectionCell.swift
//  home_work_23
//
//  Created by Natalia Drozd on 28.06.22.
//

import UIKit

class HourlyWeatherCollectionCell: UICollectionViewCell {
    @IBOutlet weak var temp: UILabel!
 @IBOutlet weak var imageWeayherView: UIImageView!
    @IBOutlet weak var hours: UILabel!
    static let key = "HourlyWeatherCollectionCell"
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
