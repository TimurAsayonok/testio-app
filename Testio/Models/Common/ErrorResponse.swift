//
//  ErrorResponse.swift
//  Testio
//
//  Created by Timur Asayonok on 19/09/2022.
//

import Foundation

struct ErrorResponse: Codable, Equatable, Error, LocalizedError {
    let message: String
    
    enum CodingKeys: String, CodingKey {
        case message
    }
}
