//
//  MapViewController.swift
//  home_work_23
//
//  Created by Natalia Drozd on 25.06.22.
//

import UIKit
import GoogleMaps
import CoreLocation

class MapViewController: UIViewController {
   // var coordinate
    private var apiProvider: RestAPIProviderProtocol!
    override func viewDidLoad() {
        super.viewDidLoad()
        apiProvider = AlamofireProvaider()
        
        let camera = GMSCameraPosition.camera(
            withLatitude: 54.029,
            longitude: 27.597,
            zoom: 10
        )
        let mapView = GMSMapView.map(withFrame: .zero, camera: camera)
        mapView.delegate = self
        view = mapView
    }
    
    private func getWeatherByCoordinates(coord: CLLocationCoordinate2D) {
        apiProvider.getWeatherForCityCoordinates(lat: coord.latitude, lon: coord.longitude) { result in
            switch result {
            case .success(let value):
               // updateUI(value.current)
                guard let current = value.current, let temp = current.temp else {return}
                let alert = UIAlertController(title: "Температура:", message: temp.description, preferredStyle: .alert)
                let okButton = UIAlertAction(title: "OK", style: .cancel)
                alert.addAction(okButton)
                self.present(alert, animated: true)
            case .failure(let error):
                print(error)
            }
        }
    }

}

extension MapViewController: GMSMapViewDelegate {
    func mapView(_ mapView: GMSMapView, didTapAt coordinate: CLLocationCoordinate2D) {
        getWeatherByCoordinates(coord: coordinate)
    }
}
