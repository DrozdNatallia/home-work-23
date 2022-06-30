//
//  RealmProvaider.swift
//  home_work_23
//
//  Created by Natalia Drozd on 30.06.22.
//

import Foundation
import RealmSwift
import UIKit

class RealmProvader: RealmProviderProtocol {
    func getResult<T: RealmFetchable>(nameObject: T.Type) -> Results<T> {
        let realm = try! Realm()
        let res = realm.objects(nameObject.self)
        return res   
    }
}
