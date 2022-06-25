//
//  RestAPIProviderProtocol.swift
//  home_work_23
//
//  Created by Natalia Drozd on 25.06.22.
//

import Foundation
import Alamofire

protocol RestAPIProviderProtocol {
    func getCoordinatesByName(name: String, completion: @escaping (Result<[InfoCity], Error>) -> Void)
    func getWeatherForCityCoordinates(lat: Double, lon: Double, completion: @escaping (Result<WeatherData, Error>) -> Void)
}
