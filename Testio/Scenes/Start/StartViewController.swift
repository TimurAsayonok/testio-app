//
//  StartViewController.swift
//  Testio
//
//  Created by Timur Asayonok on 19/09/2022.
//

import UIKit
import RxSwift
import RxCocoa

class StartViewController: BaseViewController<StartViewModel> {
    let disposeObject = DisposeBag()
    
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
    
    override func bindViewModel() {
        super.bindViewModel()
        
        print("viewModel.dependencies:", viewModel.dependencies)
        viewModel.dependencies.apiService.authLogin(
            LoginCredentials(username: "tesonet", password: "partyanimal")
        )
        .subscribe { response in
            print("response: ", response)
        }
        .disposed(by: disposeObject)
    }
    
    @objc func buttonTapped() {
//        coordinator?.eventOccered(with: .buttonTapped)
    }
}
