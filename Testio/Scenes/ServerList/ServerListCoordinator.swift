//
//  ServerListCoordinator.swift
//  Testio
//
//  Created by Timur Asayonok on 18/09/2022.
//

import UIKit

enum ServerListRoute: RouteType {
    case serverList
}

// MARK: ServerListCoordinator
// Coordinator for ServerListRoute
class ServerListCoordinator: Coordinator<ServerListRoute> {
    let dependencies: Dependencies
    
    init(route: ServerListRoute, dependencies: Dependencies) {
        self.dependencies = dependencies
        super.init(route: route)
    }
    
    /// Generates ViewController based on ServerListRoute
    override func generateViewController(for route: ServerListRoute) -> UIViewController {
        switch route {
        case .serverList:
            let viewController = ServerListViewController()
            let viewModel = ServerListViewModel(dependencies: dependencies)
            viewController.bind(to: viewModel)
            
            return viewController
        }
    }
}
