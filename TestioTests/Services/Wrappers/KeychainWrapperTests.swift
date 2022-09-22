//
//  KeychainWrapperTests.swift
//  TestioTests
//
//  Created by Timur Asayonok on 22/09/2022.
//

@testable import Testio
import Foundation
import XCTest

class KeychainWrapperTests: XCTestCase {
    var sut: KeychainWrapperProtocol!

    override func setUp() {
        super.setUp()
        
        sut = KeychainWrapper(appConfiguration: AppConfigurationProviderProtocolMock())
    }
    
    func testSetBearerToken() {
        let token = "Token"
        sut.setBearerToken(token)
        XCTAssertEqual(sut.getBearerToken(), "Bearer Token")
    }
    
    func testDeleteBearerTokem() {
        sut.deleteBearerToken()
        XCTAssertEqual(sut.getBearerToken(), nil)
    }
}
