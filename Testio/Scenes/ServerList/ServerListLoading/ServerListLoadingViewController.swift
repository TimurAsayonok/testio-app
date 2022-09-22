//
//  ServerListLoadingViewController.swift
//  Testio
//
//  Created by Timur Asayonok on 21/09/2022.
//

import UIKit
import RxSwift

// MARK: ServerListLoadingViewController
/*
 ViewController for presenting activity indicator or error message
 while working with `/servers` api call
 */
class ServerListLoadingViewController: BaseViewController<ServerListLoadingViewModel> {
    fileprivate let disposeBag = DisposeBag()
    
    var backgroundImageView: UIImageView!
    var errorMessageStack: UIStackView!
    var errorMessageLabel: UILabel!
    var reloadButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setupUI()
    }
    
    override func bindViewModel() {
        viewModel.output.loadingDriver
            .drive(rx.isLoading)
            .disposed(by: disposeBag)
        
        reloadButton.rx.tap
            .bind(to: viewModel.input.startObserver)
            .disposed(by: disposeBag)
        
        viewModel.state.loadingFailedDriver
            .map { !$0 }
            .drive(errorMessageStack.rx.isHidden)
            .disposed(by: disposeBag)
        
        viewModel.input.startObserver.onNext(())
    }
    
    override func setupUI() {
        super.setupUI()
        // background image
        UIImageView().setup {
            $0.contentMode = .scaleToFill
            $0.clipsToBounds = true
            $0.image = UIImage(named: "unsplash")
            backgroundImageView = $0
        }
        .addTo(view)
        view.sendSubviewToBack(backgroundImageView)
        
        // Error Message StackView
        UIStackView().setup {
            $0.axis = .vertical
            $0.alignment = .fill
            $0.distribution = .fill
            $0.spacing = 8
            errorMessageStack = $0
        }
        .setArrangedSubviews([
            UILabel().setup {
                $0.text = HardcodedStrings.serverListLoadingError
                $0.numberOfLines = 0
                $0.textColor = UIColor.systemGray
                $0.textAlignment = .center
                errorMessageLabel = $0
            },
            UIButton.primaryFull(title: HardcodedStrings.logIn).setup {
                reloadButton = $0
            }
        ])
        errorMessageStack.addTo(view)
        // image constraints
        NSLayoutConstraint.activate([
            backgroundImageView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0),
            backgroundImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            backgroundImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0)
        ])
        
        // FormStack constraints
        NSLayoutConstraint.activate([
            errorMessageStack.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            errorMessageStack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 32),
            errorMessageStack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -32)
        ])
    }
}
