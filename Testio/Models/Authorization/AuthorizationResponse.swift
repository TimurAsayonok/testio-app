//
//  AuthorizationResponse.swift
//  Testio
//
//  Created by Timur Asayonok on 19/09/2022.
//

import Foundation

struct AuthorizationResponse: Codable, Equatable {
    let token: String
    
    enum CodingKeys: String, CodingKey {
        case token
    }
}
