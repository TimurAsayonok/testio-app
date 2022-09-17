//
//  MainCoordinator.swift
//  Testio
//
//  Created by Timur Asayonok on 16/09/2022.
//

import UIKit

class MainCoordinator: Coordinator {
    var navigationController: UINavigationController?
    
    func eventOccered(with type: Event) {
        switch type {
        case .buttonTapped:
            let vc = SecondViewController()
            vc.coordinator = self
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    func start() {
        let vc = ViewController()
        vc.coordinator = self
        
        navigationController?.setViewControllers([vc], animated: true)
    }
}
