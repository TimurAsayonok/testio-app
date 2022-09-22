//
//  ServerListRequestTests.swift
//  TestioTests
//
//  Created by Timur Asayonok on 22/09/2022.
//

@testable import Testio
import XCTest

class ServerListRequestTests: XCTestCase {
    var sut: ServerListRequest!

    override func setUp() {
        super.setUp()
        sut = ServerListRequest()
    }

    func testMustInit() {
        XCTAssertNotNil(sut)
        XCTAssertEqual(sut.path, "/v1/servers")
    }

    func testMustHaveCorrectResponse() {
        XCTAssertEqual("\(type(of: sut).Response.self)", "\([ServerModel].self)")
    }

    func testMustHaveCorrectError() {
        XCTAssertEqual("\(type(of: sut).Error.self)", "\(ErrorResponse.self)")
    }
}
