//
//  UIView+Extentions.swift
//  Testio
//
//  Created by Timur Asayonok on 18/09/2022.
//

import UIKit

extension UIView {
    @discardableResult
    func anchorToSuperview(insets: UIEdgeInsets = .zero, ignoreSafeArea: Bool = false) -> Self {
        guard let superview = superview else { return self }
        
        return anchorTo(view: superview, insets: insets, ignoreSafeArea: ignoreSafeArea)
    }
    
    @discardableResult
    func anchorTo(view: UIView, insets: UIEdgeInsets = .zero, ignoreSafeArea: Bool = false) -> Self {
        translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            topAnchor.constraint(
                equalTo: ignoreSafeArea ? view.topAnchor : view.safeAreaLayoutGuide.topAnchor,
                constant: insets.top
            ),
            bottomAnchor.constraint(
                equalTo: ignoreSafeArea ? view.bottomAnchor : view.safeAreaLayoutGuide.bottomAnchor,
                constant: -insets.bottom
            ),
            leadingAnchor.constraint(
                equalTo: ignoreSafeArea ? view.leadingAnchor : view.safeAreaLayoutGuide.leadingAnchor,
                constant: insets.left
            ),
            trailingAnchor.constraint(
                equalTo: ignoreSafeArea ? view.trailingAnchor : view.safeAreaLayoutGuide.trailingAnchor,
                constant: -insets.right
            )
        ])
        
        return self
    }
}

extension UIView {
    @discardableResult
    func addTo(_ view: UIView) -> Self {
        translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(self)
        return self
    }

    @discardableResult
    func addAndAnchorTo(_ view: UIView, insets: UIEdgeInsets = UIEdgeInsets.zero, ignoreSafeArea: Bool = true) -> Self {
        addTo(view)
        anchorToSuperview(insets: insets, ignoreSafeArea: ignoreSafeArea)
        return self
    }
}
