//
//  AuthorizationRequestTests.swift
//  TestioTests
//
//  Created by Timur Asayonok on 22/09/2022.
//

@testable import Testio
import XCTest

class AuthorizationRequestTests: XCTestCase {
    var sut: AuthorizationRequest!

    override func setUp() {
        super.setUp()
        sut = AuthorizationRequest(
            credentials: LoginCredentialsModel(username: "username", password: "password")
        )
    }

    func testMustInit() {
        XCTAssertNotNil(sut)
        XCTAssertNotNil(sut.username)
        XCTAssertNotNil(sut.password)
        XCTAssertEqual(sut.path, "/v1/tokens")
    }

    func testMustHaveCorrectResponse() {
        XCTAssertEqual("\(type(of: sut).Response.self)", "\(AuthorizationResponse.self)")
    }

    func testMustHaveCorrectError() {
        XCTAssertEqual("\(type(of: sut).Error.self)", "\(ErrorResponse.self)")
    }
}
