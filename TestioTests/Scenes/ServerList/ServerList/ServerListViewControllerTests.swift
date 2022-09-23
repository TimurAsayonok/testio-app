//
//  ServerList.swift
//  TestioTests
//
//  Created by Timur Asayonok on 22/09/2022.
//

@testable import Testio
import Foundation
import XCTest
import RxTest
import RxSwift

class ServerListViewControllerTests: XCTestCase {
    var sut: ServerListViewController!
    var viewModel: ServerListViewModel!
    var dependencies: AppDependencyMock!
    var scheduler: TestScheduler!
    var disposeBag = DisposeBag()
    
    override func setUp() {
        sut = ServerListViewController()
        dependencies = AppDependencyMock()
        viewModel = ServerListViewModel(dependencies: dependencies)
        scheduler = TestScheduler(initialClock: 0)
        
        sut.bind(to: viewModel)
    }
    
    func testMustInit() {
        // init
        XCTAssertNotNil(sut)
        XCTAssertNotNil(sut.viewModel)
        
        // UI Elements
        XCTAssertNotNil(sut.tableView)
    }
    
    func testNumberOfRowsInTable() {
        // server list is empty, we have only Empty Cell
        XCTAssertNotNil(sut.tableView.numberOfRows(inSection: 0) == 1)
        
        // server list is not empty
        viewModel.state.serversSubject.onNext([ServerModel.mock])
        XCTAssertNotNil(sut.tableView.numberOfRows(inSection: 0) > 0)
    }
    
    func testButtonRightBarButtonItem() {
        let rightBarButtonItemObserver = scheduler.createObserver(Void.self)
        sut.navigationItem.rightBarButtonItem?.customView?.rx.tapGesture()
            .subscribe(onNext: { _ in rightBarButtonItemObserver.onNext(()) })
            .disposed(by: disposeBag)
        
        scheduler.start()
    
        XCTAssertEqual(rightBarButtonItemObserver.events.count, 1)
    }
    
    func testButtonLeftBarButtonItem() {
        let leftBarButtonItemObserver = scheduler.createObserver(Void.self)
        sut.navigationItem.leftBarButtonItem?.customView?.rx.tapGesture()
            .subscribe(onNext: { _ in leftBarButtonItemObserver.onNext(()) })
            .disposed(by: disposeBag)
        
        scheduler.start()
    
        XCTAssertEqual(leftBarButtonItemObserver.events.count, 1)
    }
}

