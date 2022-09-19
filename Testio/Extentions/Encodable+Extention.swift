//
//  Encodable+Extention.swift
//  Testio
//
//  Created by Timur Asayonok on 19/09/2022.
//

import Foundation

extension Encodable {
    func toData(jsonEncoder: JSONEncoder = JSONEncoder()) throws -> Data {
        return try jsonEncoder.encode(self)
    }
}
