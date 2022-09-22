//
//  ApiProviderTests.swift
//  TestioTests
//
//  Created by Timur Asayonok on 22/09/2022.
//

@testable import Testio
import Foundation
import XCTest
import RxTest

class ApiProviderTests: XCTestCase {
    var sut: ApiProvider!
    var appConfiguration: AppConfigurationProviderProtocolMock!
    var urlSession: URLSessionMock!
    var headersRequestDecorator: HeadersRequestDecoratorProtocolMock!
    
    override func setUp() {
        super.setUp()
        
        appConfiguration = AppConfigurationProviderProtocolMock()
        urlSession = URLSessionMock()
        headersRequestDecorator = HeadersRequestDecoratorProtocolMock()
        
        sut = ApiProvider(
            urlSession: urlSession,
            appConfiguration: appConfiguration,
            headersRequestDecorator: headersRequestDecorator
        )
    }
    
    func testMustInit() {
        XCTAssertNotNil(sut)
    }
    
    func testMustReturnBaseUrl() {
        XCTAssertEqual(sut.basedUrl, appConfiguration.apiBasedUrl)
    }
    
    func testMustSuccess() {
        urlSession.data = try? TestResponse(id: "id").toData(jsonEncoder: JSONEncoder())
        urlSession.response = HTTPURLResponse.mock(200)
        let request = TestRequest(string: "String", int: 0, bool: true)
        let result = sut.send(apiRequest: request, method: .get)
        
        XCTAssertNoThrow(try result.toBlocking().single())
        XCTAssertEqual(try result.toBlocking().single(), TestResponse(id: "id"))
    }
    
    func testMustFailWithError() {
        urlSession.error = TestRequest.Error()
        let request = TestRequest(string: "String", int: 0, bool: true)
        let result = sut.send(apiRequest: request, method: .get)
        
        XCTAssertThrowsError(try result.toBlocking().single()) { error in
            XCTAssertEqual(error as? TestError, TestError())
        }
    }
    
    func testMustFailWithStatusCode401() {
        urlSession.data = try? TestRequest.Error().toData(jsonEncoder: JSONEncoder())
        urlSession.response = HTTPURLResponse.mock(401)
        let request = TestRequest(string: "String", int: 0, bool: true)
        let result = sut.send(apiRequest: request, method: .get)
        
        XCTAssertThrowsError(try result.toBlocking().single()) { error in
            XCTAssertEqual(error as? TestError, TestError())
        }
    }
}
