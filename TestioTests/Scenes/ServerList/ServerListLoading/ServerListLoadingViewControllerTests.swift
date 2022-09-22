//
//  ServerListLoadingViewControllerTests.swift
//  TestioTests
//
//  Created by Timur Asayonok on 22/09/2022.
//

@testable import Testio
import Foundation
import XCTest

class ServerListLoadingViewControllerTests: XCTestCase {
    var sut: ServerListLoadingViewController!
    var viewModel: ServerListLoadingViewModel!
    
    override func setUp() {
        sut = ServerListLoadingViewController()
        viewModel = ServerListLoadingViewModel(dependencies: AppDependencyMock())
        
        sut.bind(to: viewModel)
    }
    
    func testMustInit() {
        // init
        XCTAssertNotNil(sut)
        XCTAssertNotNil(sut.viewModel)
        
        // UI Elements
        XCTAssertNotNil(sut.backgroundImageView)
        XCTAssertNotNil(sut.errorMessageStack)
        XCTAssertNotNil(sut.errorMessageLabel)
        XCTAssertNotNil(sut.reloadButton)
        
        // Hidden Elements by default
        XCTAssertTrue(sut.errorMessageStack.isHidden)
    }
    
    func testMustObserveReloadButton() {
        var uiActions: [UIControl.Event] = []

        sut.reloadButton.sendActions(for: .touchUpInside)
        uiActions.append(.touchUpInside)
        
        XCTAssertEqual(uiActions, [.touchUpInside])
    }
}
