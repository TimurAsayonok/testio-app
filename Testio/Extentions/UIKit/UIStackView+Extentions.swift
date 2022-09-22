//
//  UIStackView+Extentions.swift
//  Testio
//
//  Created by Timur Asayonok on 20/09/2022.
//

import Foundation
import UIKit

extension UIStackView {
    /// Sets ArrangedSubview to the UIStack removing all arrangedSubviews from Superview before
    func setArrangedSubviews(_ subviews: [UIView]) {
        empty()
        subviews.forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            addArrangedSubview($0)
        }
    }

    /// Removs all arrangedSubviews from Superview before
    func empty() {
        arrangedSubviews.forEach { $0.removeFromSuperview() }
    }
}
