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
            
            container.register {
                AppDependency(
                    userDefaults: try container.resolve()
                ) as Dependencies
            }
        }
        
    }
}
