//
//  ScreenLinkTests.swift
//  TestioTests
//
//  Created by Timur Asayonok on 22/09/2022.
//

@testable import Testio
import Foundation
import XCTest

class ScreenLinkTests: XCTestCase {
    func testMustInitWithPresentPresentation() {
        let sut = ScreenLink(StartRoute.login, presentation: .present)
        XCTAssertNotNil(sut)
        XCTAssertNotNil(sut.route)
        XCTAssertEqual(sut.presentation, .present)
    }
    
    func testMustInitWithAsRootViewPresentation() {
        let sut = ScreenLink(StartRoute.login, presentation: .asRootView)
        XCTAssertNotNil(sut)
        XCTAssertNotNil(sut.route)
        XCTAssertEqual(sut.presentation, .asRootView)
    }
    
    func testMustInitWithAsRootNavigationPresentation() {
        let sut = ScreenLink(StartRoute.login, presentation: .asRootNavigation)
        XCTAssertNotNil(sut)
        XCTAssertNotNil(sut.route)
        XCTAssertEqual(sut.presentation, .asRootNavigation)
    }
}
