//
//  HomeCoordinator.swift
//  Testio
//
//  Created by Timur Asayonok on 18/09/2022.
//

import UIKit

enum StartRoute: RouteType {
    case login
}

class StartCoordinator: Coordinator<StartRoute> {
    let dependencies: Dependencies
    
    init(route: StartRoute, dependencies: Dependencies) {
        self.dependencies = dependencies
        super.init(route: route)
    }
    
    override func generateViewController(for route: StartRoute) -> UIViewController {
        switch route {
        case .login:
            let viewController = LoginViewController()
            let viewModel = LoginViewModel(dependencies: dependencies)
            viewController.bind(to: viewModel)
            
            return viewController
        }
    }
}
