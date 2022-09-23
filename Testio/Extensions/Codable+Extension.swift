//
//  Codable+Extension.swift
//  Testio
//
//  Created by Timur Asayonok on 20/09/2022.
//

import Foundation

extension Encodable {
    func toData(_ encoder: JSONEncoder = JSONEncoder()) throws -> Data {
        try encoder.encode(self)
    }
}
