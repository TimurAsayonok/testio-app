//
//  UIViewController+Extentions.swift
//  Testio
//
//  Created by Timur Asayonok on 18/09/2022.
//

import UIKit

extension UIViewController {
    func embed(
        _ viewController: UIViewController,
        in container: UIViewController,
        with options: TransitionOptions,
        completion: TransitionCompletion?
    ) {
        container.viewController.addChild(viewController)
        container.view.addSubview(viewController.view)
        viewController.view.anchorToSuperview(ignoreSafeArea: true)
        viewController.didMove(toParent: container.viewController)

        completion?()
    }
    
    func removeAllEmbed(from container: UIViewController, completion: TransitionCompletion?) {
        container.children.forEach {
            $0.willMove(toParent: nil)
            $0.view.removeFromSuperview()
            $0.removeFromParent()
        }

        completion?()
    }
}
