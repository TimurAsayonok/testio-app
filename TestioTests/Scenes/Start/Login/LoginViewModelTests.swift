//
//  LoginViewModelTests.swift
//  TestioTests
//
//  Created by Timur Asayonok on 22/09/2022.
//

@testable import Testio
import XCTest
import RxCocoa
import RxTest
import RxSwift
import RxBlocking

class LoginViewModelTests: XCTestCase {
    var viewModel: LoginViewModel!
    var scheduler: TestScheduler!
    var disposeBag: DisposeBag!
    
    override func setUp() {
        super.setUp()
        viewModel = LoginViewModel(dependencies: AppDependencyMock())
        scheduler = TestScheduler(initialClock: 0)
        disposeBag = DisposeBag()
    }
    
    func testStateUserNameSubject() {
        let usernameObserver = scheduler.createObserver(String?.self)
        
        viewModel.state.usernameSubject.asDriver(onErrorDriveWith: .just(""))
            .drive(usernameObserver)
            .disposed(by: disposeBag)
        
        scheduler.createColdObservable([
            .next(5, "user"),
            .next(10, "username")
        ])
        .bind(to: viewModel.state.usernameSubject)
        .disposed(by: disposeBag)
        
        scheduler.start()
        
        XCTAssertEqual(usernameObserver.events, [.next(0, ""), .next(5, "user"), .next(10, "username")])
    }
    
    func testStatePasswordSubject() {
        let passwordObserver = scheduler.createObserver(String?.self)
        
        viewModel.state.passwordSubject.asDriver(onErrorDriveWith: .just(""))
            .drive(passwordObserver)
            .disposed(by: disposeBag)
        
        scheduler.createColdObservable([
            .next(5, "pass"),
            .next(10, "password")
        ])
        .bind(to: viewModel.state.passwordSubject)
        .disposed(by: disposeBag)
        
        scheduler.start()
        
        XCTAssertEqual(passwordObserver.events, [.next(0, ""), .next(5, "pass"), .next(10, "password")])
    }
    
    func testStateIsValidForm() {
        let usernameObserver = scheduler.createObserver(String?.self)
        let passwordObserver = scheduler.createObserver(String?.self)
        let isValidObserver = scheduler.createObserver(Bool.self)
        
        viewModel.state.usernameSubject.asDriver(onErrorDriveWith: .just(""))
            .drive(usernameObserver)
            .disposed(by: disposeBag)
        
        viewModel.state.passwordSubject.asDriver(onErrorDriveWith: .just(""))
            .drive(passwordObserver)
            .disposed(by: disposeBag)
        
        viewModel.state.isValidForm.asDriver(onErrorDriveWith: .just(false))
            .drive(isValidObserver)
            .disposed(by: disposeBag)
        
        scheduler.createColdObservable([
            .next(5, "user")
        ])
        .bind(to: viewModel.state.usernameSubject)
        .disposed(by: disposeBag)
        
        scheduler.createColdObservable([
            .next(10, "pass")
        ])
        .bind(to: viewModel.state.passwordSubject)
        .disposed(by: disposeBag)
        
        scheduler.start()
        
        XCTAssertEqual(isValidObserver.events, [.next(0, false), .next(5, false), .next(10, true)])
    }
    
    func testInputSubmitFormSubject() {
        let submitFormObserver = scheduler.createObserver(Bool.self)
        
        viewModel.input.submitFormDriver
            .map { _ in true}
            .drive(submitFormObserver)
            .disposed(by: disposeBag)
        
        scheduler.createColdObservable([
            .next(0, ())
        ])
        .bind(to: viewModel.input.submitFormObserver)
        .disposed(by: disposeBag)
        
        scheduler.start()
        
        XCTAssertEqual(submitFormObserver.events, [.next(0, true)])
    }
    
    func testOutputLoadingSubject() {
        let loadingObserver = scheduler.createObserver(Bool.self)
        
        viewModel.output.loadingDriver
            .drive(loadingObserver)
            .disposed(by: disposeBag)
        
        scheduler.createColdObservable([
            .next(5, true)
        ])
        .bind(to: viewModel.output.loadingObserver)
        .disposed(by: disposeBag)
        
        scheduler.start()
        
        XCTAssertEqual(loadingObserver.events, [.next(0, false), .next(5, true)])
    }
}
