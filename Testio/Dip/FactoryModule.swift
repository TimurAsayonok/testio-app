//
//  FactoryModule.swift
//  Testio
//
//  Created by Timur Asayonok on 18/09/2022.
//

import Dip

// MARK: FactoryModule
// Registering FatCoordinatorFactory and AppCoordinatorFactory
extension DipContainerBuilder {
    enum FactoryModule {
        static func build(container: DependencyContainer) {
            container.register {
                AppCoordinatorFactory(
                    fatCoordinatorFactory: try container.resolve(),
                    dependencies: try container.resolve(),
                    serverListRealmRepository: try container.resolve()
                )
            }
            
            container.register {
                FatCoordinatorFactory(
                    dependencies: try container.resolve()
                )
            }
        }
    }
}
