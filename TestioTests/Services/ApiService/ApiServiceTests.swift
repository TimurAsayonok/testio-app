//
//  ApiServiceTests.swift
//  TestioTests
//
//  Created by Timur Asayonok on 22/09/2022.
//

@testable import Testio
import Foundation
import XCTest

class ApiServiceTests: XCTestCase {
    var sut: ApiService!
    var apiProvider: ApiProvider!
    
    override func setUp() {
        super.setUp()
        let appConfiguration = AppConfigurationProviderProtocolMock()
        apiProvider = ApiProvider(
            urlSession: URLSessionMock(),
            appConfiguration: appConfiguration,
            headersRequestDecorator: HeadersRequestDecoratorProtocolMock()
        )
        
        sut = ApiService(
            apiProvider: apiProvider,
            appConfiguration: appConfiguration,
            keychain: KeychainWrapperProtocolMock()
        )
    }
  
    func testAuthLogin() {
//        let request = AuthorizationRequest(credentials: LoginCredentialsModel(username: "", password: ""))
//        let result = sut.apiProvider.post(apiRequest: request).
//        XCTAssertEqual(try result.toBlocking().single(), AuthorizationRequest.Response.init(token: ""))
    }
//    func authLogin(_ credentials: LoginCredentialsModel) -> Observable<Void> {
//        let request = AuthorizationRequest(credentials: credentials)
//        return apiProvider.post(apiRequest: request)
//            // do: save token in keychain
//            .do { [weak self] in self?.keychain.setBearerToken($0.token) }
//            .map { _ in }
//    }
//
//    func getServerList() -> Observable<[ServerModel]> {
//        let request = ServerListRequest()
//        return apiProvider.get(apiRequest: request)
//    }
}
