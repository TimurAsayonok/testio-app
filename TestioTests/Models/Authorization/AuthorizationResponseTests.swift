//
//  AuthorizationResponseTests.swift
//  TestioTests
//
//  Created by Timur Asayonok on 22/09/2022.
//

@testable import Testio
import Foundation
import XCTest

class AuthorizationResponseTests: XCTestCase {
    func testMustInitWithAllValues() {
        let sut = AuthorizationResponse(token: "Token")
        XCTAssertNotNil(sut)
        XCTAssertNotNil(sut.token)
    }
}
