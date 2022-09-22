//
//  ErrorResponseTests.swift
//  TestioTests
//
//  Created by Timur Asayonok on 22/09/2022.
//

@testable import Testio
import Foundation
import XCTest

class ErrorResponseTests: XCTestCase {
    func testMustInitWithAllValues() {
        let sut = ErrorResponse.mock
        XCTAssertNotNil(sut)
        XCTAssertNotNil(sut.message)
    }
}

extension ErrorResponse {
    static var mock: Self {
        .init(message: "error")
    }
}

