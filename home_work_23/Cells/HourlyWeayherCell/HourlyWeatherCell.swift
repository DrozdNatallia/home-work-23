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

extension HourlyWeatherCell: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return tempArray.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HourlyWeatherCollectionCell.key, for: indexPath) as? HourlyWeatherCollectionCell {
            guard let tempArray = tempArray, let dtArray = dtArray, let imageArray = imageArray else {return cell }
            cell.hours.text = dtArray[indexPath.row].description
            cell.temp.text = "\(tempArray[indexPath.row])°"
            cell.imageWeayherView.image = imageArray[indexPath.row]
            
            return cell
        }
        return UICollectionViewCell()
    }
}
