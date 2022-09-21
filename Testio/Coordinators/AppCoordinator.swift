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
        let screenLink: ScreenLink = dependencies.keychainWrapper.getBearerToken() != nil
            ? ScreenLink(ServerListRoute.serverList, presentation: .setNavigationRoot)
            : ScreenLink(StartRoute.login, presentation: .setViewRoot)
        
        dependencies.appGlobalState.screenTriggerObserver.onNext(screenLink)
    }
    
    private func observeState() {
        // handle error subject
        dependencies.appGlobalState.errorDriver
            .drive(onNext: { [weak self] error in
                self?.handleAppGlobalStateError(error)
            })
            .disposed(by: disposeBag)
        
        // handle screen trigger subject
        dependencies.appGlobalState.screenTriggerObservable
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { [weak self] screenLink in
                guard let link = screenLink else {
                    print("Failed Link:", String(describing: screenLink))
                    return
                }
                self?.trigger(link: link)
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

extension AppCoordinator {
    func trigger(link: ScreenLink) {
        guard let fatRoute = FatRoute(route: link.route)
        else { return }
        let presentable = fatCoordinatorFactory.createPresentable(fatRoute)
        
        switch link.presentation {
        case .setViewRoot:
            trigger(transition: Transition.setRoot(presentable, in: viewController))
        case .setNavigationRoot:
            let coordinator = NavigationCoordinator(presentable: presentable)
            trigger(transition: Transition.setRoot(coordinator, in: viewController))
        case .present:
            trigger(transition: Transition.present(presentable))
        }
    }
}
