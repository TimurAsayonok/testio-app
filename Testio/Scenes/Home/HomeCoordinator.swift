//
//  HomeCoordinator.swift
//  Testio
//
//  Created by Timur Asayonok on 18/09/2022.
//

import UIKit

enum HomeRoute: RouteType {
    case initHome
    case login
}

class HomeRouteCoordinator: Coordinator<HomeRoute> {
    override init(route: HomeRoute) {
        super.init(route: route)
    }
    
    override func generateViewController(for route: HomeRoute) -> UIViewController {
        switch route {
        case .initHome:
            return ViewController()
        case .login:
            return UIViewController()
        }
    }
}
