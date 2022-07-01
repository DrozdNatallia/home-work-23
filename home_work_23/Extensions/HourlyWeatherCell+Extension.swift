//
//  HourlyWeatherCell + extension.swift
//  home_work_23
//
//  Created by Natalia Drozd on 30.06.22.
//

import Foundation
import UIKit

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
