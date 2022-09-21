//
//  ServerListLoadingViewModel.swift
//  Testio
//
//  Created by Timur Asayonok on 21/09/2022.
//

import Foundation
import RxSwift
import RxCocoa

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
                    .onNext(ScreenLink(ServerListRoute.serverList(servers: servers), presentation: .setNavigationRoot)
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

extension ServerListLoadingViewModel {
    struct State {
        fileprivate let loadingFailedSubject = BehaviorSubject<Bool>(value: false)
        var loadingFailedDriver: Driver<Bool> {
            loadingFailedSubject.distinctUntilChanged().asDriver(onErrorJustReturn: false)
        }
    }
    
    struct Input {
        fileprivate var startSubject = PublishSubject<Void>()
        var startObserver: AnyObserver<Void> { startSubject.asObserver() }
    }
    
    struct Output {
        fileprivate var loadingSubject = BehaviorSubject<Bool>(value: false)
        var loadingDriver: Driver<Bool> {
            loadingSubject.distinctUntilChanged().asDriver(onErrorJustReturn: false)
        }

        fileprivate var errorSubject: PublishSubject<Error> = PublishSubject()
        var errorObservable: Observable<Error> { errorSubject.asObservable() }
    }
}
