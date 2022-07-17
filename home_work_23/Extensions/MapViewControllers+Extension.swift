//
//  MapViewControllers.swift
//  home_work_23
//
//  Created by Natalia Drozd on 26.06.22.
//

import Foundation
import GoogleMaps

extension MapViewController: GMSMapViewDelegate {
    func mapView(_ mapView: GMSMapView, didTapAt coordinate: CLLocationCoordinate2D) {
        mapView.clear()
        getWeatherByCoordinates(coord: coordinate)
    }
    
    func mapView(_ mapView: GMSMapView, markerInfoWindow marker: GMSMarker) -> UIView? {
        if let view = Bundle.main.loadNibNamed("InfoWindow", owner: self, options: nil)?.first as? CustomInfoWindow {
            guard let temp = temp, let imageWeather = imageWeather, let speedWind = speedWind else {
                return UIView()
            }
            view.temp.text = "\(NSLocalizedString("Temperature", comment: "")): \(temp)°"
            view.icon.image = imageWeather
            view.windSpeed.text = "\(NSLocalizedString("Speed Wind", comment: "")): \(Int(speedWind)) m/s"
            return view
        }
        return UIView()
    }
}
