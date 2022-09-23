//
//  ServerListRequest.swift
//  Testio
//
//  Created by Timur Asayonok on 21/09/2022.
//

import Foundation

struct ServerListRequest: RequestProtocol {
    typealias Response = [ServerModel]
    typealias Error = ErrorResponse
    
    var path: String {
        "/v1/servers"
    }
}
