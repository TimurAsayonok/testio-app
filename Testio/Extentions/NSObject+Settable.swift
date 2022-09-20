//
//  NSObject+Settable.swift
//  Testio
//
//  Created by Timur Asayonok on 20/09/2022.
//

import UIKit

protocol Settable {}

extension Settable where Self: NSObject {
    @discardableResult
    func setup(_ setup: (Self) -> Void) -> Self {
        setup(self)
        return self
    }
}

extension NSObject: Settable {}
