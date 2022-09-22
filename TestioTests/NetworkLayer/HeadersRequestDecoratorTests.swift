//
//  HeadersRequestDecoratorTests.swift
//  TestioTests
//
//  Created by Timur Asayonok on 22/09/2022.
//

@testable import Testio
import Foundation
import XCTest

class HeadersRequestDecoratorTests: XCTestCase {
    var sut: HeadersRequestDecorator!
    var keychainWrapper: KeychainWrapperProtocolMock!
    
    override func setUp() {
        super.setUp()
        
        keychainWrapper = KeychainWrapperProtocolMock()
        
        sut = HeadersRequestDecorator(keychainWrapper: keychainWrapper)
    }
    
    func testInit() {
        XCTAssertNotNil(sut)
    }
    
    func testMustDecorateWithHeaders() {
        let url = URL.mock
        var urlRequest = URLRequest(url: url)
        
        XCTAssertNil(urlRequest.allHTTPHeaderFields)
        
        sut.decorate(urlRequest: &urlRequest)
        
        let headers = urlRequest.allHTTPHeaderFields
        if let headers = headers {
            XCTAssertEqual(Array(headers.keys), [HeaderRequestKey.xAuthorization.rawValue])
            XCTAssertEqual(headers[HeaderRequestKey.xAuthorization.rawValue], "Mock Token")
        }
    }
}

