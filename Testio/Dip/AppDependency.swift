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
}

struct AppDependency: Dependencies {
    let userDefaults: UserDefaults
    let keychainWrapper: KeychainWrapperProtocol
    let apiService: ApiServiceProtocol
    let appConfigurationProvider: AppConfigurationProviderProtocol
}
