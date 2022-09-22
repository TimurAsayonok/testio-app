//
//  ApiServiceTests.swift
//  TestioTests
//
//  Created by Timur Asayonok on 22/09/2022.
//

@testable import Testio
import Foundation
import XCTest
import RxTest

class ApiServiceTests: XCTestCase {
    var sut: ApiService!
    var apiProvider: ApiProvider!
    var urlSession: URLSessionMock!
    
    override func setUp() {
        super.setUp()
        let appConfiguration = AppConfigurationProviderProtocolMock()
        urlSession = URLSessionMock()
        apiProvider = ApiProvider(
            urlSession: urlSession,
            appConfiguration: appConfiguration,
            headersRequestDecorator: HeadersRequestDecoratorProtocolMock()
        )
        
        sut = ApiService(
            apiProvider: apiProvider,
            appConfiguration: appConfiguration,
            keychain: KeychainWrapperProtocolMock()
        )
    }
  
    func testAuthLoginSuccess() {
        urlSession.data = try? AuthorizationRequest.Response.mock.toData(jsonEncoder: JSONEncoder())
        urlSession.response = HTTPURLResponse.mock(200)
        let request = AuthorizationRequest(credentials: LoginCredentialsModel.mock)
        let result = sut.apiProvider.post(apiRequest: request)
        XCTAssertEqual(try result.toBlocking().single(), AuthorizationRequest.Response.mock)
    }

    func testAuthLoginError() {
        urlSession.data = try? AuthorizationRequest.Error.mock.toData(jsonEncoder: JSONEncoder())
        urlSession.response = HTTPURLResponse.mock(401)
        let request = AuthorizationRequest(credentials: LoginCredentialsModel.mock)
        let result = sut.apiProvider.post(apiRequest: request)
        
        XCTAssertThrowsError(try result.toBlocking().single()) { error in
            XCTAssertEqual(error as? ErrorResponse, ErrorResponse.mock)
        }
    }
    
    func testGetServerListSuccess() {
        urlSession.data = try? ServerListRequest.Response([.mock]).toData(jsonEncoder: JSONEncoder())
        urlSession.response = HTTPURLResponse.mock(200)
        let request = ServerListRequest()
        let result = sut.apiProvider.get(apiRequest: request)
        XCTAssertEqual(try result.toBlocking().single(), ServerListRequest.Response([.mock]))
    }
    
    func testGetServerListError() {
        urlSession.data = try? ServerListRequest.Error.mock.toData(jsonEncoder: JSONEncoder())
        urlSession.response = HTTPURLResponse.mock(401)
        let request = ServerListRequest()
        let result = sut.apiProvider.post(apiRequest: request)
        
        XCTAssertThrowsError(try result.toBlocking().single()) { error in
            XCTAssertEqual(error as? ErrorResponse, ErrorResponse.mock)
        }
    }
}
