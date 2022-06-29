//
//  ListRequestTableCell.swift
//  home_work_23
//
//  Created by Natalia Drozd on 29.06.22.
//

import UIKit

class ListRequestTableCell: UITableViewCell {
    @IBOutlet weak var latitude: UILabel!
    @IBOutlet weak var longitude: UILabel!
    @IBOutlet weak var time: UILabel!
    @IBOutlet weak var temp: UILabel!
    @IBOutlet weak var weatherDescription: UILabel!
    static let key = "ListRequestTableCell"
    override func awakeFromNib() {
        super.awakeFromNib()

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
}
