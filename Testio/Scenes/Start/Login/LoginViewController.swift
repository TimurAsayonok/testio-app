//
//  LoginViewController.swift
//  Testio
//
//  Created by Timur Asayonok on 19/09/2022.
//

import UIKit
import RxSwift
import RxCocoa

final class LoginViewController: BaseViewController<LoginViewModel> {
    let disposeBag = DisposeBag()
    
    var backgroundImageView: UIImageView!
    var formStackView: UIStackView!
    var userNameTextField: TextField!
    var passwordTextField: TextField!
    var submitButton: UIButton!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: false)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
    }
    
    override func bindViewModel() {
        super.bindViewModel()
        
        userNameTextField.rx.text.orEmpty.distinctUntilChanged()
            .bind(to: viewModel.state.usernameSubject)
            .disposed(by: disposeBag)
        
        passwordTextField.rx.text.orEmpty.distinctUntilChanged()
            .bind(to: viewModel.state.passwordSubject)
            .disposed(by: disposeBag)
        
        viewModel.state.isValidForm
            .bind(to: submitButton.rx.isEnabled)
            .disposed(by: disposeBag)
        
        submitButton.rx.tap
            .bind(to: viewModel.input.submitFormObserver)
            .disposed(by: disposeBag)
        
        viewModel.output.loadingDriver
            .drive(rx.isLoading)
            .disposed(by: disposeBag)
    }
    
    private func setupUI() {
        let logoIconView = UIView()
        submitButton = UIButton.primaryFull(title: "Log in")
        
        // background image
        UIImageView().setup {
            $0.contentMode = .scaleToFill
            $0.clipsToBounds = true
            $0.image = UIImage(named: "unsplash")
            backgroundImageView = $0
        }
        .addTo(view)
        view.sendSubviewToBack(backgroundImageView)
        
        // logo icon
        UIImageView().setup {
            $0.clipsToBounds = true
            $0.contentMode = .scaleAspectFit
            $0.image = UIImage(named: "logo")
            $0.heightAnchor.constraint(equalToConstant: 48).isActive = true
        }
        .addAndAnchorTo(
            logoIconView,
            insets: UIEdgeInsets(
                top: 0, left: 0, bottom: 16, right: 0
            )
        )
        
        // Form View with Icon View
        UIStackView().setup {
            $0.axis = .vertical
            $0.alignment = .fill
            $0.distribution = .fill
            $0.spacing = 24
            formStackView = $0
        }
        .setArrangedSubviews([
            logoIconView,
            
            TextField().setup {
                $0.placeholder = HardcodedStrings.username
                $0.leftView = buildIcon("person.crop.circle.fill")
                $0.leftViewMode = .always
                $0.heightAnchor.constraint(equalToConstant: 40).isActive = true
                userNameTextField = $0
            },
            
            TextField().setup {
                $0.placeholder = HardcodedStrings.password
                $0.leftView = buildIcon("lock.circle.fill")
                $0.leftViewMode = .always
                $0.textContentType = .password
                $0.isSecureTextEntry = true
                $0.heightAnchor.constraint(equalToConstant: 40).isActive = true
                passwordTextField = $0
            },
            
            submitButton
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
    
    private func buildIcon(_ icon: String) -> UIImageView {
        return UIImageView().setup {
            $0.image = UIImage(systemName: icon)
            $0.contentMode = .center
        }
    }
}
