//
//  ServiceModule.swift
//  Testio
//
//  Created by Timur Asayonok on 19/09/2022.
//

import Dip

// MARK: FactoryModule
// Registering ApiService
extension DipContainerBuilder {
    enum ServiceModule {
        static func build(container: DependencyContainer) {
            container.register {
                ServerListRealmRepository(
                    realmDataManager: try container.resolve()
                ) as ServerListRealmRepositoryProtocol
            }
            
            container.register {
                ApiService(
                    apiProvider: try container.resolve(),
                    appConfiguration: try container.resolve(),
                    keychain: try container.resolve(),
                    serverListRealmRepository: try container.resolve()
                ) as ApiServiceProtocol
            }
        }
    }
}
