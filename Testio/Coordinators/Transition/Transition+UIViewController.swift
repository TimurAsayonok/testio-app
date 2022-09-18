//
//  Transition+UIViewController.swift
//  Testio
//
//  Created by Timur Asayonok on 18/09/2022.
//

import Foundation
import UIKit

extension Transition {
    static func multiple<C: Collection>(_ transitions: C) -> Transition where C.Element == Transition {
        Transition { rootViewController, options, completion in
            guard let firstTransition = transitions.first else {
                completion?()
                return
            }
            
            firstTransition.perform(on: rootViewController, with: options) {
                let newTransition = Array(transitions.dropFirst())
                Transition
                    .multiple(newTransition)
                    .perform(on: rootViewController, with: options, completion: completion)
            }
        }
    }
    
    static func dismissAll() -> Transition {
        Transition { rootViewController, options, completion in
            guard let presentedViewController = rootViewController.presentedViewController else {
                completion?()
                return
            }
            
            presentedViewController.dismiss(animated: options.animated) {
                Transition
                    .dismissAll()
                    .perform(on: rootViewController, with: options, completion: completion)
            }
        }
    }
    
    static func embed(_ presentable: Presentable, in container: UIViewController) -> Transition {
        Transition { rootViewController, options, completion in
            rootViewController.embed(
                presentable.viewController, in: container, with: options, completion: completion
            )
        }
    }
    
    static func removeAllEmbed(from container: UIViewController) -> Transition {
        Transition { rootViewController, _, completion in
            rootViewController.removeAllEmbed(from: container, completion: completion)
        }
    }
    
    static func embedRemovingOthers(_ presentable: Presentable, in container: UIViewController) -> Transition {
        Transition.multiple([
            .removeAllEmbed(from: container),
            .embed(presentable, in: container)
        ])
    }
    
    static func setRoot(_ presentable: Presentable, in container: UIViewController) -> Transition {
        Transition.multiple([
            .dismissAll(),
            .embedRemovingOthers(presentable, in: container)
        ])
    }
}
