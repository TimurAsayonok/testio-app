//
//  Coordinator.swift
//  Testio
//
//  Created by Timur Asayonok on 16/09/2022.
//

import UIKit

protocol CoordinatorType: Presentable {
    associatedtype RootViewController: UIViewController
    
    var rootViewController: RootViewController! { get }
    
    func trigger(
        transition: Transition<RootViewController>, options: TransitionOptions, completion: TransitionCompletion?
    )
}

extension CoordinatorType {
    var viewController: UIViewController! {
        rootViewController
    }
    
    func trigger(
        transition: Transition<RootViewController>,
        options: TransitionOptions = TransitionOptions(),
        completion: TransitionCompletion?
    ) {
        transition.perform(on: rootViewController, with: options, completion: completion)
    }
}

class Coordinator<Route>: CoordinatorType {
    var rootViewController: UIViewController!
    
    init(route: Route) {
        rootViewController = generateViewController(for: route)
    }
    
    func generateViewController(for route: Route) -> UIViewController {
        fatalError("Must override in subClass \(type(of: self))")
    }
}
