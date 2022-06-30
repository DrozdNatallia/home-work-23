//
//  RealmProviderProtocol.swift
//  home_work_23
//
//  Created by Natalia Drozd on 30.06.22.
//

import Foundation
import UIKit
import RealmSwift

protocol RealmProviderProtocol {
    func getResult<T: RealmFetchable>(nameObject: T.Type) -> Results<T>
}
