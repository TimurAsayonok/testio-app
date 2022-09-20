//
//  StartViewModel.swift
//  Testio
//
//  Created by Timur Asayonok on 19/09/2022.
//

import Foundation
import RxSwift
import RxCocoa

final class StartViewModel: ViewModelProtocol {
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
        input.submitFormSubject
            .withLatestFrom(state.usernameSubject.asObservable())
            .withLatestFrom(state.passwordSubject.asObservable()) {
                LoginCredentials(username: $0 ?? "", password: $1 ?? "")
            }
            .wrapService(
                loadingObserver: output.loadingSubject.asObserver(),
                errorObserver: output.errorSubject.asObserver(),
                serviceMethod: dependencies.apiService.authLogin
            )
            .subscribe()
            .disposed(by: disposeBag)
        
        output.errorSubject.asObservable()
            .subscribe { error in
                print(error)
            }
            .disposed(by: disposeBag)
    }
}

extension StartViewModel {
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

extension StartViewModel {
    struct Input {
        fileprivate var submitFormSubject = PublishSubject<Void>()
        var submitFormObserver: AnyObserver<Void> { submitFormSubject.asObserver() }
    }
}

extension StartViewModel {
    struct Output {
        fileprivate var loadingSubject = BehaviorSubject<Bool>(value: false)
        var loadingDriver: Driver<Bool> {
            loadingSubject.distinctUntilChanged().asDriver(onErrorJustReturn: false)
        }

        fileprivate var errorSubject: PublishSubject<Error> = PublishSubject()
        var errorObservable: Observable<Error> { errorSubject.asObservable() }
    }
}
