//
//  ServerListViewModelTests.swift
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

class ServerListViewModelTests: XCTestCase {
    var viewModel: ServerListViewModel!
    var scheduler: TestScheduler!
    var disposeBag: DisposeBag!
    
    override func setUp() {
        super.setUp()
        viewModel = ServerListViewModel(servers: [], dependencies: AppDependencyMock())
        scheduler = TestScheduler(initialClock: 0)
        disposeBag = DisposeBag()
    }
    
    func testInputStartSubject() {
        let startObserver = scheduler.createObserver(Bool.self)
        
        viewModel.input.startDriver
            .map { _ in true }
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
    
    func testInputLogoutSubject() {
        let logoutObserver = scheduler.createObserver(Bool.self)
        
        viewModel.input.logoutDriver
            .map { _ in true }
            .drive(logoutObserver)
            .disposed(by: disposeBag)
        
        scheduler.createColdObservable([
            .next(0, ())
        ])
        .bind(to: viewModel.input.logoutObserver)
        .disposed(by: disposeBag)
        
        scheduler.start()
        
        XCTAssertEqual(logoutObserver.events, [.next(0, true)])
    }
    
    func testInputDataModelSubject() {
        typealias SectionDataModel = [ServerListViewModel.SectionDataModel]
        let dataModelObserver = scheduler.createObserver(SectionDataModel.self)
        let dataModelMock: SectionDataModel = [
            .init(model: .list, items: [.empty, .item(ServerModel(name: "Name", distance: 0))])
        ]
        
        viewModel.input.dataModelsDriver
            .drive(dataModelObserver)
            .disposed(by: disposeBag)

        scheduler.createColdObservable([
            .next(5, dataModelMock)
        ])
        .bind(to: viewModel.input.dataModelsObserver)
        .disposed(by: disposeBag)
        
        scheduler.start()
        
        XCTAssertEqual(dataModelObserver.events, [.next(0, []), .next(5, dataModelMock)])
    }
}

