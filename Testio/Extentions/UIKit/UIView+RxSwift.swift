//
//  UIView+RxSwift.swift
//  Testio
//
//  Created by Timur Asayonok on 20/09/2022.
//

import Foundation
import UIKit
import RxSwift

public extension Reactive where Base: UIView {
    var isLoading: Binder<Bool> {
        Binder(base) { view, isLoading -> Void in
            // delete activity indicator
            if isLoading == false {
                return view.subviews
                    .compactMap { $0 as? UIActivityIndicatorView }
                    .forEach { $0.removeFromSuperview() }
            }
            
            // Skip adding new `UIActivityIndicatorView` due to existing one already
            guard view.subviews.first(where: { ($0 as? UIActivityIndicatorView) != nil }) == nil else {
                return
            }
            
            let activityIndicator = UIActivityIndicatorView(style: .medium).setup {
                $0.hidesWhenStopped = true
                $0.translatesAutoresizingMaskIntoConstraints = false
                $0.color = UIColor.black
            }
            activityIndicator.startAnimating()
            view.addSubview(activityIndicator)
            view.bringSubviewToFront(activityIndicator)
            
            NSLayoutConstraint.activate([
                activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor)
            ])
        }
    }
}
