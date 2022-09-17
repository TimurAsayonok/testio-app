//
//  SecondViewController.swift
//  Testio
//
//  Created by Timur Asayonok on 16/09/2022.
//

import UIKit

class SecondViewController: UIViewController, Coordinating {
    var coordinator: Coordinator?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        title = "Second"
    }
}
