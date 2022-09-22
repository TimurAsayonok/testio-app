//
//  ServerListItemTableViewCellTests.swift
//  TestioTests
//
//  Created by Timur Asayonok on 22/09/2022.
//

@testable import Testio
import Foundation
import XCTest

class ServerListItemTableViewCellTests: XCTestCase {
    var sut: ServerListItemTableViewCell!
    
    override func setUp() {
        sut = ServerListItemTableViewCell()
        sut.setupWith(model: ServerModel(name: "Server", distance: 0))
    }
    
    func testMustInit() {
        // init
        XCTAssertNotNil(sut)
        
        // UI Elements
        XCTAssertNotNil(sut.distanceLabel)
        XCTAssertNotNil(sut.serverLabel)
    }
}
