//
//  ViewModelBindableProtocol.swift
//  Testio
//
//  Created by Timur Asayonok on 19/09/2022.
//

import Foundation
import UIKit

protocol ViewModelBindableProtocol: AnyObject {
    associatedtype ViewModel

    var viewModel: ViewModel! { get set }

    func bindViewModel()
}

extension ViewModelBindableProtocol where Self: UIViewController {
    func bind(to viewModel: Self.ViewModel) {
        self.viewModel = viewModel
        loadViewIfNeeded()
        bindViewModel()
    }
}
