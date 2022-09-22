//
//  ServerModelTests.swift
//  TestioTests
//
//  Created by Timur Asayonok on 22/09/2022.
//

@testable import Testio
import Foundation
import XCTest

class ServerModelTests: XCTestCase {
    func testMustInitOnlyWithDefaultValues() {
        let sut = ServerModel(name: nil, distance: nil)
        XCTAssertNotNil(sut)
        XCTAssertNil(sut.name)
        XCTAssertNil(sut.distance)
    }

    func testMustInitWithAllValues() {
        let sut = ServerModel.mock
        XCTAssertNotNil(sut)
        XCTAssertNotNil(sut.name)
        XCTAssertNotNil(sut.distance)
    }
}

extension ServerModel {
    static var mock: Self {
        .init(name: "name", distance: 0)
    }
}
