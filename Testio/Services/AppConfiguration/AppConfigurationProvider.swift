//
//  AppConfigurationProvider.swift
//  Testio
//
//  Created by Timur Asayonok on 19/09/2022.
//

import Foundation

protocol AppConfigurationProviderProtocol {
    var keychainService: String { get }
    var apiBasedUrl: URL { get }
}

// MARK: AppConfigurationProvider
// Contains all needed parameters for the Application
class AppConfigurationProvider: AppConfigurationProviderProtocol {
    // service name for keychain
    var keychainService: String {
        "com.testioapp.user"
    }
    
    // api url
    private let apiBasedUrlString = "https://playground.tesonet.lt"
    var apiBasedUrl: URL {
        URL(string: apiBasedUrlString)! // swiftlint:disable:this force_unwrapping
    }
}
