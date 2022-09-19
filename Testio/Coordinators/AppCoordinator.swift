//
//  MainCoordinator.swift
//  Testio
//
//  Created by Timur Asayonok on 16/09/2022.
//

import UIKit

struct AppCoordinatorFactory {
    let fatCoordinatorFactory: FatCoordinatorFactory
    let dependencies: Dependencies
    
    func create() -> AppCoordinator {
        AppCoordinator(
            fatCoordinatorFactory: fatCoordinatorFactory,
            dependencies: dependencies
        )
    }
}

// MARK: - AppCoordinator

class AppCoordinator: CoordinatorType {
    var rootViewController: UIViewController! = UIViewController()
    
    let fatCoordinatorFactory: FatCoordinatorFactory
    let dependencies: Dependencies
    
    init(fatCoordinatorFactory: FatCoordinatorFactory, dependencies: Dependencies) {
        self.fatCoordinatorFactory = fatCoordinatorFactory
        self.dependencies = dependencies
        rootViewController.view.backgroundColor = UIColor.white
    }
    
    func boot() {
        print("Boot")
        
        let fatRoute = FatRoute.start(StartRoute.initStart)
        let presentable = fatCoordinatorFactory.createPresentable(fatRoute)
        
        trigger(transition: Transition.setRoot(presentable, in: viewController), completion: nil)
    }
}
