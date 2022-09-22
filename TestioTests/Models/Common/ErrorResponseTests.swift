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
        let sut = ErrorResponse(message: "Error")
        XCTAssertNotNil(sut)
        XCTAssertNotNil(sut.message)
    }
}

