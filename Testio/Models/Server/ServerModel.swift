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

    enum CodingKeys: String, CodingKey {
        case nameKey = "name"
        case distanceKey = "distance"
    }
}
