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
    
    var backgroundImageView: UIImageView!
    var formStackView: UIStackView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
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
    
    private func setupUI() {
        UIImageView().setup {
            $0.contentMode = .scaleToFill
            $0.clipsToBounds = true
            $0.image = UIImage(named: "unsplash")
            backgroundImageView = $0
        }
        .addTo(view)
        view.sendSubviewToBack(backgroundImageView)
        
        UIStackView().setup {
            $0.axis = .vertical
            $0.alignment = .fill
            $0.distribution = .fill
            $0.spacing = 24
            formStackView = $0
        }
        .setArrangedSubviews([
            UIImageView().setup {
                $0.clipsToBounds = true
                $0.contentMode = .scaleAspectFit
                $0.image = UIImage(named: "logo")
                $0.heightAnchor.constraint(equalToConstant: 48).isActive = true
                $0.widthAnchor.constraint(equalToConstant: 170).isActive = true
            }
        ])
        formStackView.addTo(view)
                
        // image constraints
        NSLayoutConstraint.activate([
            backgroundImageView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0),
            backgroundImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            backgroundImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0)
        ])
        
        // FormStack constraints
        NSLayoutConstraint.activate([
            formStackView.topAnchor.constraint(equalTo: view.topAnchor, constant: 153),
            formStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 32),
            formStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -32)
        ])
    }
    
    @objc func buttonTapped() {
//        coordinator?.eventOccered(with: .buttonTapped)
    }
}
