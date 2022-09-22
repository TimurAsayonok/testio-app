//
//  ServerListEmptyTableViewCellTests.swift
//  TestioTests
//
//  Created by Timur Asayonok on 22/09/2022.
//

@testable import Testio
import Foundation
import XCTest

class ServerListEmptyTableViewCellTests: XCTestCase {
    var sut: ServerListEmptyTableViewCell!
    
    override func setUp() {
        sut = ServerListEmptyTableViewCell()
    }
    
    func testMustInit() {
        // init
        XCTAssertNotNil(sut)
        
        // UI Elements
        XCTAssertNotNil(sut.distanceLabel)
        XCTAssertNotNil(sut.serverLabel)
    }
}
