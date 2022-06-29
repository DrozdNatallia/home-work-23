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
        getWeatherByCoordinates(coord: coordinate)
    }
}
