//
//  Transition.swift
//  Testio
//
//  Created by Timur Asayonok on 17/09/2022.
//

import UIKit

typealias TransitionCompletion = () -> Void

protocol TransitionType {
    associatedtype RootViewController = UIViewController
    
    func perform(
        on rootViewController: RootViewController,
        with options: TransitionOptions,
        completion: TransitionCompletion?
    )
}

struct Transition<RootViewController: UIViewController>: TransitionType {
    typealias PerformClosure = (
        _ rootViewController: RootViewController,
        _ options: TransitionOptions,
        _ completion: TransitionCompletion?
    ) -> Void

    private var perform: PerformClosure
    
    init(perform: @escaping PerformClosure) {
        self.perform = perform
    }

    func perform(
        on rootViewController: RootViewController,
        with options: TransitionOptions,
        completion: TransitionCompletion?
    ) {
        DispatchQueue.main.async {
            self.perform(rootViewController, options, completion)
        }
    }

}
