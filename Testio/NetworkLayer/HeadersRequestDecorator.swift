//
//  HeadersRequestDecorator.swift
//  Testio
//
//  Created by Timur Asayonok on 21/09/2022.
//

import Foundation

protocol HeadersRequestDecoratorProtocol {
    var requestHeaders: [String: String?] { get }
    func decorate(urlRequest: inout URLRequest)
}

class HeadersRequestDecorator: HeadersRequestDecoratorProtocol {
    let keychainWrapper: KeychainWrapperProtocol
    
    init(keychainWrapper: KeychainWrapperProtocol) {
        self.keychainWrapper = keychainWrapper
    }
    
    var requestHeaders: [String: String?] {
        [HeaderRequestKey.xAuthorization.rawValue: keychainWrapper.getBearerToken()]
    }
    
    func decorate(urlRequest: inout URLRequest) {
        requestHeaders.forEach { key, value in
            urlRequest.setValue(value, forHTTPHeaderField: key)
        }
    }
}

enum HeaderRequestKey: String {
    case xAuthorization = "Authorization"
}
