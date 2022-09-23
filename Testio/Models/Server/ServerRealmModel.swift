//
//  ServerRealmModel.swift
//  Testio
//
//  Created by Timur Asayonok on 23/09/2022.
//

import Foundation
import RealmSwift

class ServerRealmModel: Object {
    @objc dynamic var name: String = ""
    @objc dynamic var distance: Int = 0
    
    convenience init(name: String, distance: Int) {
        self.init()
        self.name = name
        self.distance = distance
    }
}
