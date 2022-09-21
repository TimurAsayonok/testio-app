//
//  BaseViewController.swift
//  Testio
//
//  Created by Timur Asayonok on 19/09/2022.
//

import Foundation
import UIKit

class BaseViewController<ViewModel>: UIViewController, ViewModelBindableProtocol {
    var viewModel: ViewModel!
    
    func bindViewModel() {}
    func setupUI() {}
    
    deinit {
        print("💥 \(type(of: self))")
    }
}
