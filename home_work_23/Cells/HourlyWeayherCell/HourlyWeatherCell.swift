//
//  HourlyWeatherCell.swift
//  home_work_23
//
//  Created by Natalia Drozd on 28.06.22.
//

import UIKit

class HourlyWeatherCell: UITableViewCell {
    @IBOutlet weak var collectionView: UICollectionView!
    static let key = "HourlyWeatherCell"
    var tempArray: [Double]!
    var dtArray: [String]!
    var imageArray: [UIImage]!
    override func awakeFromNib() {
        super.awakeFromNib()
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(UINib(nibName: "HourlyWeatherCollectionCell", bundle: nil), forCellWithReuseIdentifier: HourlyWeatherCollectionCell.key)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
