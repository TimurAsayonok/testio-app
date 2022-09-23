//
//  ServerListRealmModel.swift
//  Testio
//
//  Created by Timur Asayonok on 23/09/2022.
//

import Foundation
import RealmSwift

class ServerListRealmModel: Object {
    var items = List<ServerRealmModel>()
    
    convenience init(items: List<ServerRealmModel>) {
        self.init()
        self.items = items
    }
    
    static func makeListFrom(servers: [ServerModel]) -> ServerListRealmModel {
        let serverList = ServerListRealmModel()
        servers.forEach { serverList.items.append($0.mapToRealmModel()) }
        
        return serverList
    }
}
