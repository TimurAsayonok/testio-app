//
//  ViewController.swift
//  Testio
//
//  Created by Timur Asayonok on 15/09/2022.
//

import UIKit

class ViewController: UIViewController {
//    var coordinator: Coordinator?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        print("did load")
        
        view.backgroundColor = .red
        title = "home"
        
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: 220, height: 55))
        button.center = view.center
        button.backgroundColor = .systemGreen
        button.setTitle("Press", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        
        view.addSubview(button)
    }
    
    @objc func buttonTapped() {
//        coordinator?.eventOccered(with: .buttonTapped)
    }

}
