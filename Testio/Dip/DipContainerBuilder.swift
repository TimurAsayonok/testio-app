//
//  DipContainerBuilder.swift
//  Testio
//
//  Created by Timur Asayonok on 16/09/2022.
//

import Dip
import Foundation

// MARK: DipContainerBuilder
// DependencyContainer builder
class DipContainerBuilder {
    static func build() -> DependencyContainer {
        let container = DependencyContainer()
        
        DependencyModule.build(container: container)
        FactoryModule.build(container: container)
        NetworkModule.build(container: container)
        ServiceModule.build(container: container)
        
        return container
    }
}
