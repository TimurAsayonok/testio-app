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
    
    func testStateServersSubject() {
        let serversObserver = scheduler.createObserver([ServerModel].self)
        
        viewModel.state.serversSubject.asDriver(onErrorJustReturn: [])
            .drive(serversObserver)
            .disposed(by: disposeBag)
        
        scheduler.createColdObservable([
            .next(5, [ServerModel.mock])
        ])
        .bind(to: viewModel.state.serversSubject)
        .disposed(by: disposeBag)
        
        scheduler.start()
        
        XCTAssertEqual(serversObserver.events, [.next(0, []), .next(5, [ServerModel.mock])])
    }
    
    func testFilterStatusSubject() {
        let filterStatusObserver = scheduler.createObserver(ServerListViewModel.Filter.self)
        
        viewModel.state.filterStatusSubject.asDriver(onErrorJustReturn: .byName)
            .drive(filterStatusObserver)
            .disposed(by: disposeBag)
        
        scheduler.createColdObservable([
            .next(5, .byDistance)
        ])
        .bind(to: viewModel.state.filterStatusSubject)
        .disposed(by: disposeBag)
        
        scheduler.start()
        
        XCTAssertEqual(filterStatusObserver.events, [.next(0, .byName), .next(5, .byDistance)])
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
    
    func testInputPresentFilterModalViewSubject() {
        let presentFilterObserver = scheduler.createObserver(Bool.self)
        
        viewModel.input.presentFilterModalViewDriver
            .map { _ in true }
            .drive(presentFilterObserver)
            .disposed(by: disposeBag)
        
        scheduler.createColdObservable([
            .next(0, ())
        ])
        .bind(to: viewModel.input.presentFilterModalViewObserver)
        .disposed(by: disposeBag)
        
        scheduler.start()
        
        XCTAssertEqual(presentFilterObserver.events, [.next(0, true)])
    }
    
    func testInputDataModelSubject() {
        typealias SectionDataModel = [ServerListViewModel.SectionDataModel]
        let dataModelObserver = scheduler.createObserver(SectionDataModel.self)
        let emptyItemsDataModelMock: SectionDataModel = [.init(model: .list, items: [])]
        let dataModelMock: SectionDataModel = [
            .init(model: .list, items: [.item(ServerModel.mock)])
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
        
        XCTAssertEqual(
            dataModelObserver.events,
            [.next(0, SectionDataModel(emptyItemsDataModelMock)), .next(5, SectionDataModel(dataModelMock))]
        )
    }
}

