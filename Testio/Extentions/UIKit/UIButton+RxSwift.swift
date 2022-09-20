//
//  UIButton+RxSwift.swift
//  Testio
//
//  Created by Timur Asayonok on 20/09/2022.
//

import UIKit
import RxSwift

extension Reactive where Base: UIButton {
   public var isEnabled: Binder<Bool> {
        return Binder(self.base) { button, valid in
            button.isEnabled = valid
            button.alpha = valid ? 1 : 0.5
        }
    }
}
