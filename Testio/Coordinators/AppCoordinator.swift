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
    let serverListRealmRepository: ServerListRealmRepositoryProtocol
    
    func create() -> AppCoordinator {
        AppCoordinator(
            fatCoordinatorFactory: fatCoordinatorFactory,
            dependencies: dependencies,
            serverListRealmRepository: serverListRealmRepository
        )
    }
}

// MARK: AppCoordinator
// Root Coordinator
class AppCoordinator: CoordinatorType {
    private let disposeBag = DisposeBag()
    
    var rootViewController: UIViewController! = UIViewController()
    
    let fatCoordinatorFactory: FatCoordinatorFactory
    let dependencies: Dependencies
    let serverListRealmRepository: ServerListRealmRepositoryProtocol
    
    init(
        fatCoordinatorFactory: FatCoordinatorFactory,
        dependencies: Dependencies,
        serverListRealmRepository: ServerListRealmRepositoryProtocol
    ) {
        self.fatCoordinatorFactory = fatCoordinatorFactory
        self.dependencies = dependencies
        self.serverListRealmRepository = serverListRealmRepository
        rootViewController.view.backgroundColor = UIColor.white
        
        observeState()
    }
    
    func boot() {
        
        let screenLink: ScreenLink = dependencies.keychainWrapper.getBearerToken() != nil
            ? ScreenLink(ServerListRoute.serverList, presentation: .asRootNavigation)
            : ScreenLink(StartRoute.login, presentation: .asRootView)
        
        dependencies.appGlobalState.screenTriggerObserver.onNext(screenLink)
    }
    
    private func observeState() {
        
        // handle error subject
        // NOTE: This is workaround for having the same Error Title And Message as on Design
        // from Server we will get not a good Error information
        dependencies.appGlobalState.errorDriver
            .map { _ -> ScreenLink in
                ScreenLink(
                    AlertRoute.alert(
                        title: HardcodedStrings.verificationFailedTitle,
                        message: HardcodedStrings.verificationFailedMessage
                    ),
                    presentation: .present
                )
            }
            .drive(dependencies.appGlobalState.screenTriggerObserver)
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
}

extension AppCoordinator {
    /// Triggers Screen based on link presentation
    /// - parameters link: ScreenLink
    func trigger(link: ScreenLink) {
        guard let fatRoute = FatRoute(route: link.route) else { return }
        let presentable = fatCoordinatorFactory.createPresentable(fatRoute)
        
        switch link.presentation {
        case .asRootView:
            trigger(transition: Transition.setRoot(presentable, in: viewController))
        case .asRootNavigation:
            let coordinator = NavigationCoordinator(presentable: presentable)
            trigger(transition: Transition.setRoot(coordinator, in: viewController))
        case .present:
            trigger(transition: Transition.present(presentable))
        }
    }
}
