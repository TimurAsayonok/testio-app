//
//  UIViewController+RxSwift.swift
//  Testio
//
//  Created by Timur Asayonok on 20/09/2022.
//

import Foundation
import UIKit
import RxSwift

public extension Reactive where Base: UIViewController {
    var isLoading: Binder<Bool> {
        base.view.rx.isLoading
    }
}
