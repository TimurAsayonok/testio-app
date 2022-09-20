//
//  LoginCredentials.swift
//  Testio
//
//  Created by Timur Asayonok on 19/09/2022.
//

import Foundation

struct LoginCredentials: Codable, Equatable {
    let username: String
    let password: String
}