//
//  UrlParametersEncoder.swift
//  Testio
//
//  Created by Timur Asayonok on 19/09/2022.
//

import Foundation

protocol ParametersEncoder {
    func encode(_ urlRequest: URLRequest, with parameters: [String: Any]?) throws -> URLRequest
}

struct UrlParametersEncoder: ParametersEncoder {
    func encode(_ urlRequest: URLRequest, with parameters: [String : Any]?) throws -> URLRequest {
        var urlRequest = urlRequest
        
        guard let parameters = parameters else { return urlRequest }
        
        guard let url = urlRequest.url,
              let urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: false) else {
            throw Error.badUrlComponents
        }
        
        if urlRequest.value(forHTTPHeaderField: "Content-Type") == nil {
            urlRequest.setValue(
                "application/x-www-form-urlencoded; charset=utf-8",
                forHTTPHeaderField: "Content-Type"
            )
        }
        
        return urlRequest
    }
}

extension UrlParametersEncoder {
    enum Error: Swift.Error {
        case badUrlComponents
    }
}
