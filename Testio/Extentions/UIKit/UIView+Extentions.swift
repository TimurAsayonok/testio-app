//
//  UIView+Extentions.swift
//  Testio
//
//  Created by Timur Asayonok on 18/09/2022.
//

import UIKit

extension UIView {
    
    /// Anchors to super view with insets
    @discardableResult
    func anchorToSuperview(insets: UIEdgeInsets = .zero, ignoreSafeArea: Bool = false) -> Self {
        guard let superview = superview else { return self }
        
        return anchorTo(view: superview, insets: insets, ignoreSafeArea: ignoreSafeArea)
    }
    
    /// Anchors to specific view with insets
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
    
    /// Removes subview from view
    func removeSubviews() {
        subviews.forEach { $0.removeFromSuperview() }
    }
}

extension UIView {
    /// Adds view to specific view
    @discardableResult
    func addTo(_ view: UIView) -> Self {
        translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(self)
        return self
    }

    /// Adds and Anchors to specific view
    @discardableResult
    func addAndAnchorTo(_ view: UIView, insets: UIEdgeInsets = UIEdgeInsets.zero, ignoreSafeArea: Bool = true) -> Self {
        addTo(view)
        anchorToSuperview(insets: insets, ignoreSafeArea: ignoreSafeArea)
        return self
    }
}

extension UIView {
    /// Creates UIView as a line with custom color and height
    static func separator(color: UIColor = .systemGray5, height: CGFloat = 1) -> UIView {
        let separator = UIView()
        separator.backgroundColor = color
        separator.translatesAutoresizingMaskIntoConstraints = false
        separator.heightAnchor.constraint(equalToConstant: height).isActive = true
        return separator
    }
}

