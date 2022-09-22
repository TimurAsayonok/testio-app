//
//  ServerListLoadingViewModelTests.swift
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

class ServerListLoadingViewModelTests: XCTestCase {
    var viewModel: ServerListLoadingViewModel!
    var scheduler: TestScheduler!
    var disposeBag: DisposeBag!
    
    override func setUp() {
        super.setUp()
        viewModel = ServerListLoadingViewModel(dependencies: AppDependencyMock())
        scheduler = TestScheduler(initialClock: 0)
        disposeBag = DisposeBag()
    }
    
    func testStateLoadingFailedSubject() {
        let loadingFailedObserver = scheduler.createObserver(Bool.self)
        
        viewModel.state.loadingFailedDriver
            .drive(loadingFailedObserver)
            .disposed(by: disposeBag)
        
        scheduler.createColdObservable([
            .next(5, true)
        ])
        .bind(to: viewModel.state.loadingFaildeObserver)
        .disposed(by: disposeBag)
        
        scheduler.start()
        
        XCTAssertEqual(loadingFailedObserver.events, [.next(0, false), .next(5, true)])
    }
    
    func testInputStartSubject() {
        let startObserver = scheduler.createObserver(Bool.self)
        
        viewModel.input.startDriver
            .map { _ in true}
            .drive(startObserver)
            .disposed(by: disposeBag)
        
        scheduler.createColdObservable([
            .next(0, ())
        ])
        .bind(to: viewModel.input.startObserver)
        .disposed(by: disposeBag)
        
        scheduler.start()
        
        XCTAssertEqual(startObserver.events, [.next(0, true)])
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
