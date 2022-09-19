//
//  AppConfigurationProvider.swift
//  Testio
//
//  Created by Timur Asayonok on 19/09/2022.
//

import Foundation

protocol AppConfigurationProviderProtocol {
    // base url
    var keychainService: String { get }
}

class AppConfigurationProvider: AppConfigurationProviderProtocol {
    var keychainService: String {
        "com.testioapp.user"
    }
}
