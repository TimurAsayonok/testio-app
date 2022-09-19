//
//  ServiceModule.swift
//  Testio
//
//  Created by Timur Asayonok on 19/09/2022.
//

import Dip

extension DipContainerBuilder {
    enum ServiceModule {
        static func build(container: DependencyContainer) {
            container.register {
                ApiService(
                    apiProvider: try container.resolve(),
                    appConfiguration: try container.resolve()
                ) as ApiServiceProtocol
            }
        }
    }
}
