//
//  AppConfigProviderTests.swift
//  TestioTests
//
//  Created by Timur Asayonok on 22/09/2022.
//

@testable import Testio
import Foundation
import XCTest

class AppConfigProviderTests: XCTestCase {
    var sut: AppConfigurationProvider!
    
    override func setUp() {
        super.setUp()
        sut = AppConfigurationProvider()
    }
    
    func testKeychainService() {
        XCTAssertEqual(sut.keychainService, "com.testioapp.user")
    }
    
    func testApiBasedUrl() {
        XCTAssertEqual(sut.apiBasedUrl, URL(string: "https://playground.tesonet.lt"))
    }
}
