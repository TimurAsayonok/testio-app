//
//  LoginViewController.swift
//  Testio
//
//  Created by Timur Asayonok on 19/09/2022.
//

import UIKit
import RxSwift
import RxCocoa

// MARK: LoginViewController
/*
 ViewController for presenting login for
 with username, password text fields and submit button
 */
final class LoginViewController: BaseViewController<LoginViewModel> {
    fileprivate let disposeBag = DisposeBag()
    
    var backgroundImageView: UIImageView!
    var formStackView: UIStackView!
    var userNameTextField: TextField!
    var passwordTextField: TextField!
    var submitButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
    }
    
    override func bindViewModel() {
        super.bindViewModel()
        
        // handle value from `userName` text field and bind to viewModel
        userNameTextField.rx.text.orEmpty.distinctUntilChanged()
            .bind(to: viewModel.state.usernameSubject)
            .disposed(by: disposeBag)
        
        // handle value from `password` text field and bind to viewModel
        passwordTextField.rx.text.orEmpty.distinctUntilChanged()
            .bind(to: viewModel.state.passwordSubject)
            .disposed(by: disposeBag)
        
        // handle submit `button` tap event and bind to viewModel
        submitButton.rx.tap
            .bind(to: viewModel.input.submitFormObserver)
            .disposed(by: disposeBag)
        
        // handle `state.isValid` value and bind to submitButton isEnabled
        viewModel.state.isValidForm
            .bind(to: submitButton.rx.isEnabled)
            .disposed(by: disposeBag)
        
        // handle loading from viewModel
        viewModel.output.loadingDriver
            .drive(rx.isLoading)
            .disposed(by: disposeBag)
    }
    
    override func setupUI() {
        super.setupUI()
        
        let logoIconView = UIView()
        
        // background image
        UIImageView().setup {
            $0.contentMode = .scaleToFill
            $0.clipsToBounds = true
            $0.image = Asset.unsplash
            backgroundImageView = $0
        }
        .addTo(view)
        view.sendSubviewToBack(backgroundImageView)
        
        // logo image view
        UIImageView().setup {
            $0.clipsToBounds = true
            $0.contentMode = .scaleAspectFit
            $0.image = Asset.logo
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
            
            // user name text field
            TextField().setup {
                $0.placeholder = HardcodedStrings.username
                $0.leftView = buildIcon(Asset.personCropCircleFill)
                $0.leftViewMode = .always
                $0.heightAnchor.constraint(equalToConstant: 40).isActive = true
                userNameTextField = $0
            },
            
            // password text field
            TextField().setup {
                $0.placeholder = HardcodedStrings.password
                $0.leftView = buildIcon(Asset.lockCircleFill)
                $0.leftViewMode = .always
                $0.textContentType = .password
                $0.isSecureTextEntry = true
                $0.heightAnchor.constraint(equalToConstant: 40).isActive = true
                passwordTextField = $0
            },
            
            // submit button
            UIButton.primaryFull(title: HardcodedStrings.logIn).setup {
                submitButton = $0
            }
        ])
        formStackView.addTo(view)
                
        // image constraints
        NSLayoutConstraint.activate([
            backgroundImageView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0),
            backgroundImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            backgroundImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0)
        ])
        
        // formStack constraints
        NSLayoutConstraint.activate([
            formStackView.topAnchor.constraint(equalTo: view.topAnchor, constant: 153),
            formStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 32),
            formStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -32)
        ])
    }
}

extension LoginViewController {
    /// Builds UIImageView
    /// - parameters:
    ///     - icon: Icon have for the imageView
    /// - returns: UIImageView
    private func buildIcon(_ icon: UIImage) -> UIImageView {
        return UIImageView().setup {
            $0.image = icon
            $0.contentMode = .center
        }
    }
}
