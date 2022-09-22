//
//  AppDependency.swift
//  Testio
//
//  Created by Timur Asayonok on 18/09/2022.
//

import Foundation

protocol Dependencies {
    var userDefaults: UserDefaults { get }
    var keychainWrapper: KeychainWrapperProtocol { get }
    var apiService: ApiServiceProtocol { get }
    var appConfigurationProvider: AppConfigurationProviderProtocol { get }
    var appGlobalState: AppGlobalState { get }
    var headersRequestDecorator: HeadersRequestDecoratorProtocol { get }
}

// MARK: AppDependency
// Dependencies what can be injected to the screens
struct AppDependency: Dependencies {
    let userDefaults: UserDefaults
    let keychainWrapper: KeychainWrapperProtocol
    let apiService: ApiServiceProtocol
    let appConfigurationProvider: AppConfigurationProviderProtocol
    let appGlobalState: AppGlobalState
    let headersRequestDecorator: HeadersRequestDecoratorProtocol
}
