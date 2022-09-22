//
//  ApiService.swift
//  Testio
//
//  Created by Timur Asayonok on 19/09/2022.
//

import Foundation
import RxSwift

protocol ApiServiceProtocol {
    func authLogin(_ credentials: LoginCredentialsModel) -> Observable<Void>
    func getServerList() -> Observable<[ServerModel]>
}

// MARK: ApiService
// Contains api service methods
class ApiService: ApiServiceProtocol {
    let apiProvider: ApiProviderProtocol
    let appConfiguration: AppConfigurationProviderProtocol
    let keychain: KeychainWrapperProtocol
    
    init(
        apiProvider: ApiProviderProtocol,
        appConfiguration: AppConfigurationProviderProtocol,
        keychain: KeychainWrapperProtocol
    ) {
        self.apiProvider = apiProvider
        self.appConfiguration = appConfiguration
        self.keychain = keychain
    }
    
    /// Calls token from the server
    /// - parameters: credentials: LoginCredentialsModel
    /// - returns: Observable<Void>
    func authLogin(_ credentials: LoginCredentialsModel) -> Observable<Void> {
        let request = AuthorizationRequest(credentials: credentials)
        return apiProvider.post(apiRequest: request)
            // do: save token in keychain
            .do { [weak self] in self?.keychain.setBearerToken($0.token) }
            .map { _ in }
    }
    
    /// Calls list of servers
    /// - returns: Observable<[ServerModel]>
    func getServerList() -> Observable<[ServerModel]> {
        let request = ServerListRequest()
        return apiProvider.get(apiRequest: request)
    }
}
