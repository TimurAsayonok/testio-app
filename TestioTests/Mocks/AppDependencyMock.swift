//
//  AppDependencyMock.swift
//  TestioTests
//
//  Created by Timur Asayonok on 21/09/2022.
//

@testable import Testio
import Foundation

struct AppDependencyMock: Dependencies {
    var keychainWrapper: KeychainWrapperProtocol = KeychainWrapperProtocolMock()
    var apiService: ApiServiceProtocol = ApiServiceProtocolMock()
    var appConfigurationProvider: AppConfigurationProviderProtocol = AppConfigurationProviderProtocolMock()
    var appGlobalState: AppGlobalState = AppGlobalState()
    var headersRequestDecorator: HeadersRequestDecoratorProtocol = HeadersRequestDecoratorProtocolMock()
    var userDefaults = UserDefaults.mock()
}
