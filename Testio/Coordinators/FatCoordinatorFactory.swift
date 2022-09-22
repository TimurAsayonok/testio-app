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

// Route of all routes in the app
enum FatRoute: RouteType {
    case alert(AlertRoute)
    case start(StartRoute)
    case serverList(ServerListRoute)
    
    init?(route: RouteType) {
        switch route {
        case let route as AlertRoute: self = .alert(route)
        case let route as StartRoute: self = .start(route)
        case let route as ServerListRoute: self = .serverList(route)
        default: return nil
        }
    }
}

// MARK: FatCoordinatorFactory
// Main coordinator for all routes in the app
struct FatCoordinatorFactory {
    let dependencies: Dependencies
    
    init(dependencies: Dependencies) {
        self.dependencies = dependencies
    }
    
    /// Creates Presentable for route
    func createPresentable(_ fatRoute: FatRoute) -> Presentable {
        switch fatRoute {
        case let .alert(route): return AlertCoordinator(route: route)
        case let .start(route): return StartCoordinator(route: route, dependencies: dependencies)
        case let .serverList(route): return ServerListCoordinator(route: route, dependencies: dependencies)
        }
    }
}
