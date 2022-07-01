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
    private var apiProvider: RestAPIProviderProtocol!
    private var provaider: RealmProvader!
    override func viewDidLoad() {
        super.viewDidLoad()
        provaider = RealmProvader()
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
    
    func getWeatherByCoordinates(coord: CLLocationCoordinate2D) {
        apiProvider.getWeatherForCityCoordinates(lat: coord.latitude, lon: coord.longitude) { [weak self] result in
            guard let self = self else {return}
            switch result {
            case .success(let value):
                guard let current = value.current, let temp = current.temp, let lat = value.lat, let lon = value.lon, let weather = current.weather, let weatherDescription = weather.first?.description else {return}
                let data = Int(Date().timeIntervalSince1970)
                self.provaider.setCurrentWeatherQueryList(temp: temp, weather: weatherDescription, time: data)
                self.provaider.setQueryList(lat: lat, lon: lon, time: data)
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

