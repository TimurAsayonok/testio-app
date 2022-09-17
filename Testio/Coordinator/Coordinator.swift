//
//  Coordinator.swift
//  Testio
//
//  Created by Timur Asayonok on 16/09/2022.
//

import UIKit

enum Event {
    case buttonTapped
}

protocol Coordinator {
    var navigationController: UINavigationController? { get set }
    
    func eventOccered(with type: Event)
    func start()
}

protocol Coordinating {
    var coordinator: Coordinator? { get set }
}
