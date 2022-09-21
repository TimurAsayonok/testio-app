//
//  ServerModel.swift
//  Testio
//
//  Created by Timur Asayonok on 20/09/2022.
//

import Foundation

struct ServerModel: Codable, Equatable {
    let name: String?
    let distance: Int?

    enum CodingKeys: String, CodingKey {
        case name
        case distance
    }
}
