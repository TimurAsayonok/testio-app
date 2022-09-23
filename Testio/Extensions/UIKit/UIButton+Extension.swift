//
//  UIButton+Extension.swift
//  Testio
//
//  Created by Timur Asayonok on 20/09/2022.
//

import Foundation
import UIKit

extension UIButton {
    static func primaryFull(title: String) -> UIButton {
        let button = UIButton()
        button.setAttributedTitle(
            NSAttributedString(string: title, attributes: [.foregroundColor: UIColor.white]),
            for: .normal
        )
        button.heightAnchor.constraint(equalToConstant: 52).isActive = true
        button.backgroundColor = UIColor.systemBlue
        button.layer.cornerRadius = 10
        
        return button
    }
}
