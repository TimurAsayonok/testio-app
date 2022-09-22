//
//  LoginCredentialsModelTests.swift
//  TestioTests
//
//  Created by Timur Asayonok on 22/09/2022.
//

@testable import Testio
import Foundation
import XCTest

class LoginCredentialsModelTests: XCTestCase {
    func testMustInitWithAllValues() {
        let sut = LoginCredentialsModel.mock
        XCTAssertNotNil(sut)
        XCTAssertNotNil(sut.username)
        XCTAssertNotNil(sut.password)
    }
}

extension LoginCredentialsModel {
    static var mock: Self {
        .init(username: "name", password: "password")
    }
}
