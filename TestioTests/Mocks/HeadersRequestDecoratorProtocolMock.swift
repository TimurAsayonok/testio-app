//
//  HeadersRequestDecoratorProtocolMock.swift
//  TestioTests
//
//  Created by Timur Asayonok on 21/09/2022.
//

@testable import Testio
import Foundation

class HeadersRequestDecoratorProtocolMock: HeadersRequestDecoratorProtocol {
    var requestHeaders: [String : String?] {
        [HeaderRequestKey.xAuthorization.rawValue: "Bearer Token"]
    }
    
    func decorate(urlRequest: inout URLRequest) {
        requestHeaders.forEach { key, value in
            urlRequest.setValue(value, forHTTPHeaderField: key)
        }
    }
}
