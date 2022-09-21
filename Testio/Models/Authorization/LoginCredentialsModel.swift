//
//  LoginCredentials.swift
//  Testio
//
//  Created by Timur Asayonok on 19/09/2022.
//

import Foundation

struct LoginCredentialsModel: Codable, Equatable {
    let username: String
    let password: String
    
    init(username: String, password: String) {
        self.username = username
        self.password = password
    }
}
