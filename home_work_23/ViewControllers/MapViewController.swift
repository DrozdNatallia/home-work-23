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
    private var provaider: RealmProviderProtocol!
    var mapView: GMSMapView?
    var imageWeather: UIImage!
    var temp: Int!
    var speedWind: Double!
    override func viewDidLoad() {
        super.viewDidLoad()
        provaider = RealmProvader()
        apiProvider = AlamofireProvaider()
        
        let camera = GMSCameraPosition.camera(
            withLatitude: 54.029,
            longitude: 27.597,
            zoom: 10
        )
        mapView = GMSMapView.map(withFrame: .zero, camera: camera)
        guard let mapView = mapView else {
            return
        }

        mapView.delegate = self
        view = mapView
    }
    
    func getWeatherByCoordinates(coord: CLLocationCoordinate2D) {
        apiProvider.getWeatherForCityCoordinates(lat: coord.latitude, lon: coord.longitude) { [weak self] result in
            guard let self = self else {return}
            switch result {
            case .success(let value):
                guard let current = value.current, let temp = current.temp, let lat = value.lat, let lon = value.lon, let weather = current.weather, let weatherDescription = weather.first?.description, let icon = weather.first?.icon, let speed = current.windSpeed else {return}
                let data = Int(Date().timeIntervalSince1970)
                self.provaider.setCurrentWeatherQueryList(temp: temp, weather: weatherDescription, time: data, isCurrentWeather: false)
                self.provaider.setQueryList(lat: lat, lon: lon, time: data)
                self.temp = Int(temp)

                if let url = URL(string: "https://openweathermap.org/img/wn/\(icon)@2x.png") {
                    do {
                        let data = try Data(contentsOf: url)
                        self.imageWeather = UIImage(data: data)
                    } catch _ {
                        print("error")
                    }
                }
                self.speedWind = speed
                let position = CLLocationCoordinate2D(latitude: coord.latitude, longitude: coord.longitude)
                let marker = GMSMarker(position: position)
                guard let mapView = self.mapView else {
                    return
                }
                marker.map = mapView
                mapView.selectedMarker = marker
            case .failure(let error):
                print(error)
            }
        }
    }

}

