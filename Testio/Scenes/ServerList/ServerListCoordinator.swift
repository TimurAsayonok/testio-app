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

class ServerListCoordinator: Coordinator<ServerListRoute> {
    override init(route: ServerListRoute) {
        super.init(route: route)
    }
    
    override func generateViewController(for route: ServerListRoute) -> UIViewController {
        switch route {
        case .serverList: return UIViewController()
        }
    }
}

