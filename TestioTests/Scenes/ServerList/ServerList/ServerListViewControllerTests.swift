//
//  ServerList.swift
//  TestioTests
//
//  Created by Timur Asayonok on 22/09/2022.
//

@testable import Testio
import Foundation
import XCTest

class ServerListViewControllerTests: XCTestCase {
    var sut: ServerListViewController!
    var viewModel: ServerListViewModel!
    var dependencies: AppDependencyMock!
    
    override func setUp() {
        sut = ServerListViewController()
        dependencies = AppDependencyMock()
        viewModel = ServerListViewModel(servers: [], dependencies: dependencies)
        
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
    
    //TODO: ADD NavigationBatItemEvents
}

