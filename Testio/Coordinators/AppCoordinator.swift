//
//  MainCoordinator.swift
//  Testio
//
//  Created by Timur Asayonok on 16/09/2022.
//

import UIKit
import RxSwift
import RxCocoa

struct AppCoordinatorFactory {
    let fatCoordinatorFactory: FatCoordinatorFactory
    let dependencies: Dependencies
    
    func create() -> AppCoordinator {
        AppCoordinator(
            fatCoordinatorFactory: fatCoordinatorFactory,
            dependencies: dependencies
        )
    }
}

// MARK: - AppCoordinator

class AppCoordinator: CoordinatorType {
    private let disposeBag = DisposeBag()
    
    var rootViewController: UIViewController! = UIViewController()
    
    let fatCoordinatorFactory: FatCoordinatorFactory
    let dependencies: Dependencies
    
    init(fatCoordinatorFactory: FatCoordinatorFactory, dependencies: Dependencies) {
        self.fatCoordinatorFactory = fatCoordinatorFactory
        self.dependencies = dependencies
        rootViewController.view.backgroundColor = UIColor.white
        
        observeState()
    }
    
    func boot() {
//        let fatRoute = FatRoute.start(StartRoute.initStart)
//        let presentable = fatCoordinatorFactory.createPresentable(fatRoute)
        let farRoute = FatRoute.serverList(ServerListRoute.serverList)
        let presentable = fatCoordinatorFactory.createPresentable(farRoute)
        let coordinator = NavigationCoordinator(presentable: presentable)
        
        trigger(transition: Transition.setRoot(coordinator, in: viewController), completion: nil)
    }
    
    private func observeState() {
        dependencies.appGlobalState.errorDriver
            .drive(onNext: { [weak self] error in
                self?.handleAppGlobalStateError(error)
            })
            .disposed(by: disposeBag)
    }
    
    private func handleAppGlobalStateError(_ error: Error) {
        let alert = UIAlertController(
            title: HardcodedStrings.verificationFailedTitle,
            message: HardcodedStrings.verificationFailedMessage,
            preferredStyle: .alert
        )

        // add an action (button)
        alert.addAction(
            UIAlertAction(title: "OK", style: .default, handler: nil)
        )
        
        rootViewController.present(alert, animated: true)
    }
}
