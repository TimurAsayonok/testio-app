//
//  ServerModel.swift
//  Testio
//
//  Created by Timur Asayonok on 20/09/2022.
//

import Foundation

struct ServerModel: Codable, Equatable {
    private let nameKey: String?
    private let distanceKey: Int?
    
    var name: String {
        nameKey ?? ""
    }
    
    var distance: Int {
        distanceKey ?? 0
    }
    
    init(name: String?, distance: Int?) {
        self.nameKey = name
        self.distanceKey = distance
    }

    enum CodingKeys: String, CodingKey {
        case nameKey = "name"
        case distanceKey = "distance"
    }
}

extension ServerModel: MappableModelProtocol {
    func mapToRealmModel() -> ServerRealmModel {
        return ServerRealmModel(name: name, distance: distance)
    }
    
    static func mapFromRealmModel(_ model: ServerRealmModel) -> ServerModel {
        return ServerModel(name: model.name, distance: model.distance)
    }
}
