//
//  DependencyModule.swift
//  Testio
//
//  Created by Timur Asayonok on 18/09/2022.
//

import Dip
import Foundation

extension DipContainerBuilder {
    enum DependencyModule {
        static func build(container: DependencyContainer) {
            container.register { UserDefaults.standard }
            
            container.register { AppGlobalState() } 
            
            container.register {
                KeychainWrapper(
                    appConfiguration: try container.resolve()
                ) as KeychainWrapperProtocol
            }
            
            container.register(.singleton) {
                AppConfigurationProvider() as AppConfigurationProviderProtocol
            }
            
            container.register {
                AppDependency(
                    userDefaults: try container.resolve(),
                    keychainWrapper: try container.resolve(),
                    apiService: try container.resolve(),
                    appConfigurationProvider: try container.resolve(),
                    appGlobalState: try container.resolve()
                ) as Dependencies
            }
        }
        
    }
}
