//
//  Transition+UINavigationController.swift
//  Testio
//
//  Created by Timur Asayonok on 21/09/2022.
//

import Foundation
import UIKit

extension Transition where RootViewController: UINavigationController {
    static func push(_ presentable: Presentable) -> Transition {
        Transition { rootViewController, options, completion in
            rootViewController.pushViewController(presentable.viewController, animated: true)
        }
    }
}
