//
//  NetworkModule.swift
//  Testio
//
//  Created by Timur Asayonok on 19/09/2022.
//

import Dip
import Foundation

extension DipContainerBuilder {
    enum NetworkModule {
        static func build(container: DependencyContainer) {
            container.register {
                ApiProvider(
                    urlSession: try container.resolve(),
                    appConfiguration: try container.resolve()
                ) as ApiProviderProtocol
            }
            
            container.register { () -> URLSessionConfiguration in
                let configuration = URLSessionConfiguration.default
                configuration.requestCachePolicy = .reloadIgnoringLocalCacheData
                configuration.urlCache = nil
                return configuration
            }
            
            container.register { URLSession(configuration: $0) }
        }
    }
}
