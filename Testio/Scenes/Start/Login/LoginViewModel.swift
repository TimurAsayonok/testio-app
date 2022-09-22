//
//  LoginViewModel.swift
//  Testio
//
//  Created by Timur Asayonok on 19/09/2022.
//

import Foundation
import RxSwift
import RxCocoa

// MARK: LoginViewModel
/*
 ViewModel for presenting login form
 */
final class LoginViewModel: ViewModelProtocol {
    fileprivate var disposeBag = DisposeBag()
    
    var input: Input = Input()
    var output: Output = Output()
    
    var state: State = State()
    
    let dependencies: Dependencies
    
    init(dependencies: Dependencies) {
        self.dependencies = dependencies
        
        bindSubjects()
    }
    
    func bindSubjects() {
        // handle submit subject and call `/token` api call
        // if - api call is finished successfully - redirect to server list loading page
        // else - throw an error
        input.submitFormSubject
            .withLatestFrom(state.usernameSubject.asObservable())
            .withLatestFrom(state.passwordSubject.asObservable()) {
                LoginCredentialsModel(username: $0 ?? "", password: $1 ?? "")
            }
            .wrapService(
                loadingObserver: output.loadingSubject.asObserver(),
                errorObserver: output.errorSubject.asObserver(),
                serviceMethod: dependencies.apiService.authLogin
            )
            .subscribe(onNext: { [weak self] in
                self?.dependencies.appGlobalState.screenTriggerObserver
                    .onNext(ScreenLink(ServerListRoute.listLoading, presentation: .asRootView))
            })
            .disposed(by: disposeBag)
        
        // handle error
        output.errorSubject.asObservable()
            .bind(to: dependencies.appGlobalState.errorObserver)
            .disposed(by: disposeBag)
    }
}

// MARK: State
extension LoginViewModel {
    struct State {
        let usernameSubject = BehaviorSubject<String?>(value: "")
        let passwordSubject = BehaviorSubject<String?>(value: "")
        
        var isValidForm: Observable<Bool> {
            Observable.combineLatest(usernameSubject, passwordSubject) {
                if $0?.isEmpty != true && $1?.isEmpty != true { return true }
                return false
            }
        }
    }
}

// MARK: Input
extension LoginViewModel {
    struct Input {
        fileprivate var submitFormSubject = PublishSubject<Void>()
        var submitFormObserver: AnyObserver<Void> { submitFormSubject.asObserver() }
        var submitFormDriver: Driver<Void> { submitFormSubject.asDriver(onErrorJustReturn: ()) }
    }
}

// MARK: Output
extension LoginViewModel {
    struct Output {
        fileprivate var errorSubject: PublishSubject<Error> = PublishSubject()
        
        fileprivate var loadingSubject = BehaviorSubject<Bool>(value: false)
        var loadingObserver: AnyObserver<Bool> { loadingSubject.asObserver() }
        var loadingDriver: Driver<Bool> { loadingSubject.asDriver(onErrorJustReturn: false) }
    }
}
