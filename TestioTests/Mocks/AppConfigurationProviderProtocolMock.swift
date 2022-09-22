//
//  AppConfigurationProviderProtocolMock.swift
//  TestioTests
//
//  Created by Timur Asayonok on 21/09/2022.
//

@testable import Testio
import Foundation

class AppConfigurationProviderProtocolMock: AppConfigurationProviderProtocol {
    var keychainService: String {
        "com.testioapp.user.mock"
    }
    
    var apiBasedUrl: URL {
        URL(string: "https://playground.tesonet.lt")!
    }
}
