//
//  SettingsCells.swift
//  home_work_23
//
//  Created by Natalia Drozd on 16.07.22.
//

import UIKit

class SettingsCells: UITableViewCell {
    static let key = "SettingsCells"
    
    @IBOutlet weak var iconView: UIImageView!
    @IBOutlet weak var settingName: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
