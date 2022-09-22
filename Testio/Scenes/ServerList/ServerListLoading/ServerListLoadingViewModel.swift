//
//  ServerListLoadingViewModel.swift
//  Testio
//
//  Created by Timur Asayonok on 21/09/2022.
//

import Foundation
import RxSwift
import RxCocoa

// MARK: ServerListLoadingViewModel
/*
 Model for calling `/serves` api call
 and navigate to list of servers for presenting activity indicator or error message
 */
final class ServerListLoadingViewModel: ViewModelProtocol {
    fileprivate let disposeBag = DisposeBag()
    
    let input: Input = Input()
    let output: Output = Output()
    
    let state: State = State()
    
    let dependencies: Dependencies
    
    init(dependencies: Dependencies) {
        self.dependencies = dependencies
        
        bindSubjects()
    }
    
    func bindSubjects() {
        input.startSubject.asObservable()
            .do(onDispose: { [weak self] in self?.state.loadingFailedSubject.onNext(false) })
            .wrapService(
                loadingObserver: output.loadingSubject.asObserver(),
                errorObserver: output.errorSubject.asObserver(),
                serviceMethod: dependencies.apiService.getServerList
            )
            .subscribe(onNext: { [weak self] servers in
                self?.dependencies.appGlobalState.screenTriggerObserver
                    .onNext(ScreenLink(ServerListRoute.serverList(servers: servers), presentation: .asRootNavigation)
                )
            })
            .disposed(by: disposeBag)
        
        output.errorSubject.asObservable()
            .subscribe(onNext: { [weak self] in
                self?.dependencies.appGlobalState.errorObserver.onNext($0)
                self?.state.loadingFailedSubject.onNext(true)
            })
            .disposed(by: disposeBag)
    }
}

// MARK: State
extension ServerListLoadingViewModel {
    struct State {
        fileprivate let loadingFailedSubject = BehaviorSubject<Bool>(value: false)
        var loadingFaildeObserver: AnyObserver<Bool> { loadingFailedSubject.asObserver() }
        var loadingFailedDriver: Driver<Bool> { loadingFailedSubject.asDriver(onErrorJustReturn: false) }
    }
}

// MARK: Input
extension ServerListLoadingViewModel {
    struct Input {
        fileprivate var startSubject = PublishSubject<Void>()
        var startObserver: AnyObserver<Void> { startSubject.asObserver() }
        var startDriver: Driver<Void> { startSubject.asDriver(onErrorJustReturn: ()) }
    }
}

// MARK: Output
extension ServerListLoadingViewModel {
    struct Output {
        fileprivate var loadingSubject = BehaviorSubject<Bool>(value: false)
        var loadingObserver: AnyObserver<Bool> { loadingSubject.asObserver() }
        var loadingDriver: Driver<Bool> { loadingSubject.asDriver(onErrorJustReturn: false) }

        fileprivate var errorSubject: PublishSubject<Error> = PublishSubject()
        var errorObservable: Observable<Error> { errorSubject.asObservable() }
    }
}
