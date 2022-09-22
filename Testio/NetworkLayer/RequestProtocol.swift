//
//  RequestProtocol.swift
//  Testio
//
//  Created by Timur Asayonok on 19/09/2022.
//

import Foundation

protocol RequestProtocol: Encodable {
    associatedtype Response: Codable
    associatedtype Error: Swift.Error & Codable
    
    var path: String { get }
}

// MARK: RequestProtocol
// Contains addition function for working with Request
extension RequestProtocol {
    
    /// Returns JSONEncoder
    static func getJSONEncoder() -> JSONEncoder {
        return JSONEncoder()
    }
    
    /// Returns JSON Decoder
    static func getJSONDecoder() -> JSONDecoder {
        return JSONDecoder()
    }
    
    /// Returns ParametersEncoder for the request method type
    func getParametersEncoder(_ method: HTTPMethod) -> ParametersEncoder {
        switch method {
        case .get, .delete: return UrlParametersEncoder()
        case .post, .put: return JsonParametersEncoder()
        }
    }
    
    /// Builds `URLRequest` for `URL` and `http method type`
    func buildRequest(with basedUrl: URL, method: HTTPMethod) throws -> URLRequest {
        let url = basedUrl.appendingPathComponent(path)
        
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        
        return try getParametersEncoder(method).encode(request, with: try toDictionary())
    }
    
    func toDictionary() throws -> [String: Any] {
        let data = try toData(jsonEncoder: Self.getJSONEncoder())
        let anySerialized = try JSONSerialization.jsonObject(with: data)

        guard let dictionary = anySerialized as? [String: Any] else {
            throw RequestProtocolError.wrongSerialization
        }
        return dictionary
    }
}

enum RequestProtocolError: Swift.Error {
    case wrongSerialization
}
