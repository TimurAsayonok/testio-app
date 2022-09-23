//
//  AuthorizationRequest.swift
//  Testio
//
//  Created by Timur Asayonok on 19/09/2022.
//

import Foundation
import RxSwift

struct AuthorizationRequest: RequestProtocol {
    typealias Response = AuthorizationResponse
    typealias Error = ErrorResponse
    
    var path: String {
        "/v1/tokens"
    }
    
    let username: String
    let password: String
    
    init(credentials: LoginCredentialsModel) {
        self.username = credentials.username
        self.password = credentials.password
    }
}

extension AuthorizationRequest {
    enum CodingKeys: String, CodingKey {
        case username
        case password
    }
}
