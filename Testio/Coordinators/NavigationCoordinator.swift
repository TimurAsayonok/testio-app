//
//  NavigationCoordinator.swift
//  Testio
//
//  Created by Timur Asayonok on 20/09/2022.
//

import Foundation
import UIKit

// MARK: NavigationCoordinator
// Coordinator for UINavigationController
class NavigationCoordinator: CoordinatorType {
    var rootViewController: UINavigationController!

    init(presentable: Presentable?) {
        if let presentable = presentable {
            rootViewController = UINavigationController(rootViewController: presentable.viewController)
        } else {
            rootViewController = UINavigationController()
        }
    }

    deinit {
        print("💥 \(type(of: self))")
    }
}
