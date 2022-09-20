//
//  UIStackView+Extentions.swift
//  Testio
//
//  Created by Timur Asayonok on 20/09/2022.
//

import Foundation
import UIKit

// MARK: - FunctionBuilder

@resultBuilder
public enum AETStackViewBuilder {
    public static func buildBlock(_ subViews: UIView?...) -> [UIView] {
        subViews.compactMap { $0 }
    }
}

extension UIStackView {
    func setArrangedSubviews(_ subviews: [UIView]) {
        empty()
        subviews.forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            addArrangedSubview($0)
        }
    }

    func empty() {
        arrangedSubviews.forEach { $0.removeFromSuperview() }
    }
    
    private static func create(
        arrangedSubviews: [UIView],
        axis: NSLayoutConstraint.Axis,
        alignment: UIStackView.Alignment,
        distribution: UIStackView.Distribution,
        spacing: CGFloat
    ) -> UIStackView {
        arrangedSubviews.forEach { $0.translatesAutoresizingMaskIntoConstraints = false }

        let stackView = UIStackView(arrangedSubviews: arrangedSubviews)
        stackView.axis = axis
        stackView.alignment = alignment
        stackView.distribution = distribution
        stackView.spacing = spacing
        return stackView
    }
    
    static func horizontal(
        alignment: UIStackView.Alignment = .fill,
        distribution: UIStackView.Distribution = .fill,
        spacing: CGFloat = 0,
        @AETStackViewBuilder _ subViews: () -> [UIView]
    ) -> UIStackView {
        UIStackView.create(
            arrangedSubviews: subViews(),
            axis: .horizontal,
            alignment: alignment,
            distribution: distribution,
            spacing: spacing
        )
    }

    static func vertical(
        alignment: UIStackView.Alignment = .fill,
        distribution: UIStackView.Distribution = .fill,
        spacing: CGFloat = 0,
        @AETStackViewBuilder _ subViews: () -> [UIView]
    ) -> UIStackView {
        UIStackView.create(
            arrangedSubviews: subViews(),
            axis: .vertical,
            alignment: alignment,
            distribution: distribution,
            spacing: spacing
        )
    }
}
