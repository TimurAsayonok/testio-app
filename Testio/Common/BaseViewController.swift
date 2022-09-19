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
    
    func paintNavigationBar(with color: UIColor) {
        guard let navBar = navigationController?.navigationBar else { return }
        navBar.barTintColor = color

        if #available(iOS 15.0, *) { // apply fix for iOS 15 ignoring barTintColor
            let navigationBarAppearance = getDefaultNavigationBarAppearance()
            navigationBarAppearance.backgroundColor = color
            navBar.standardAppearance = navigationBarAppearance
            navBar.scrollEdgeAppearance = navigationBarAppearance
        }
    }
    
    func bindViewModel() {}
    
    deinit {
        print("💥 \(type(of: self))")
    }
}

extension BaseViewController {
    private func getDefaultNavigationBarAppearance() -> UINavigationBarAppearance {
        let navigationBarAppearance = UINavigationBarAppearance()
        navigationBarAppearance.backgroundColor = .white
        navigationBarAppearance.shadowColor = nil
        
        return navigationBarAppearance
    }
}
