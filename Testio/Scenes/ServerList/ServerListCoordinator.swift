//
//  ServerListCoordinator.swift
//  Testio
//
//  Created by Timur Asayonok on 18/09/2022.
//

import UIKit

enum ServerListRoute: RouteType {
    case serverList(servers: [ServerModel])
    case listLoading
}

class ServerListCoordinator: Coordinator<ServerListRoute> {
    let dependencies: Dependencies
    
    init(route: ServerListRoute, dependencies: Dependencies) {
        self.dependencies = dependencies
        super.init(route: route)
    }
    
    override func generateViewController(for route: ServerListRoute) -> UIViewController {
        switch route {
        case let .serverList(servers):
            let viewController = ServerListViewController()
            let viewModel = ServerListViewModel(servers: servers, dependencies: dependencies)
            viewController.bind(to: viewModel)
            
            return viewController
            
        case .listLoading:
            let viewController = ServerListLoadingViewController()
            let viewModel = ServerListLoadingViewModel(dependencies: dependencies)
            viewController.bind(to: viewModel)
            
            return viewController
        }
    }
}
