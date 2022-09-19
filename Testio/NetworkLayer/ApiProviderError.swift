//
//  ApiProviderError.swift
//  Testio
//
//  Created by Timur Asayonok on 19/09/2022.
//

import Foundation

enum ApiProviderError<E: Swift.Error>: Swift.Error, Equatable where E: Equatable {
    case deserializationError(error: E, urlResponse: HTTPURLResponse)
    case apiError(error: E, urlResponse: HTTPURLResponse)
}
