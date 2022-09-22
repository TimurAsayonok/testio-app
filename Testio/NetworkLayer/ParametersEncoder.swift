//
//  UrlParametersEncoder.swift
//  Testio
//
//  Created by Timur Asayonok on 19/09/2022.
//

import Foundation

// MARK: ParametersEncoder
// Encoder for working with urlRequest
protocol ParametersEncoder {
    func encode(_ urlRequest: URLRequest, with parameters: [String: Any]?) throws -> URLRequest
}

// MARK: UrlParametersEncoder
struct UrlParametersEncoder: ParametersEncoder {
    /// Encodes parameters in the urlRequest
    /// `Note: for next integrations we need to add addition code!`
    func encode(_ urlRequest: URLRequest, with parameters: [String: Any]?) throws -> URLRequest {
        var urlRequest = urlRequest
        
        if urlRequest.value(forHTTPHeaderField: "Content-Type") == nil {
            urlRequest.setValue(
                "application/x-www-form-urlencoded; charset=utf-8",
                forHTTPHeaderField: "Content-Type"
            )
        }
        
        return urlRequest
    }
}

// MARK: JsonParametersEncoder
struct JsonParametersEncoder: ParametersEncoder {
    /// Encodes parameters to the urlRequest httpBody
    func encode(_ urlRequest: URLRequest, with parameters: [String: Any]?) throws -> URLRequest {
        var urlRequest = urlRequest
        
        guard let parameters = parameters else { return urlRequest }
        
        let data = try JSONSerialization.data(withJSONObject: parameters)
        
        if urlRequest.value(forHTTPHeaderField: "Content-Type") == nil {
            urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        }
        
        urlRequest.httpBody = data
        
        return urlRequest
    }
}

extension UrlParametersEncoder {
    enum Error: Swift.Error {
        case badUrlComponents
    }
}
