//
//  KeychainWrapper.swift
//  Testio
//
//  Created by Timur Asayonok on 19/09/2022.
//

import KeychainAccess

protocol KeychainWrapperProtocol {
    func setBearerToken(_ token: String?)
    func getBearerToken() -> String?
    func deleteBearerToken()
}

// MARK: KeychainWrapper
// Works with Keychain in the Application
class KeychainWrapper: KeychainWrapperProtocol {
    let keychain: Keychain
    
    init(appConfiguration: AppConfigurationProviderProtocol) {
        self.keychain = Keychain(service: appConfiguration.keychainService)
            .accessibility(.whenUnlocked)
    }
    
    /// Sets BearerToken
    /// - parameters: token: String?
    func setBearerToken(_ token: String?) {
        if let token = token {
            try? keychain.set("Bearer \(token)", key: Key.bearerToken.rawValue)
        }
    }
    
    /// Gets BearerToken
    func getBearerToken() -> String? {
        try? keychain.get(Key.bearerToken.rawValue)
    }
    
    /// Deletes BearerToken
    func deleteBearerToken() {
        try? keychain.remove(Key.bearerToken.rawValue)
    }
}

extension KeychainWrapper {
    enum Key: String {
        case bearerToken
    }
}
