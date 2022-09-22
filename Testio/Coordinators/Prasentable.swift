//
//  Prasentable.swift
//  Testio
//
//  Created by Timur Asayonok on 17/09/2022.
//

import UIKit

protocol Presentable {
    var viewController: UIViewController! { get }
}

extension Presentable {
    func setRoot(for window: UIWindow) {
        window.rootViewController = viewController
        window.makeKeyAndVisible()
    }
}
