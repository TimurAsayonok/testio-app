//
//  FatCoordinatorFactory.swift
//  Testio
//
//  Created by Timur Asayonok on 18/09/2022.
//

import Foundation

protocol RouteType {}

extension RouteType {
    var id: String {
        "\(type(of: self)).\(self)"
    }
}

enum FatRoute: RouteType {
    case alert(AlertRoute)
    case home(HomeRoute)
    case serverList(ServerListRoute)
    
    init?(route: RouteType) {
        switch route {
        case let route as AlertRoute: self = .alert(route)
        case let route as HomeRoute: self = .home(route)
        case let route as ServerListRoute: self = .serverList(route)
        default: return nil
        }
    }
}

struct FatCoordinatorFactory {
    let dependencies: Dependencies
    
    init(dependencies: Dependencies) {
        self.dependencies = dependencies
    }
    
    func createPresentable(_ fatRoute: FatRoute) -> Presentable {
        switch fatRoute {
        case let .alert(route): return AlertCoordinator(route: route)
        case let .home(route): return HomeRouteCoordinator(route: route)
        case let .serverList(route): return ServerListCoordinator(route: route)
        }
    }
}
