//
//  ApiService.swift
//  Testio
//
//  Created by Timur Asayonok on 19/09/2022.
//

import Foundation
import RxSwift

protocol ApiServiceProtocol {
    func authLogin(_ credentials: LoginCredentialsModel) -> Observable<AuthorizationResponse>
    func getServerList() -> Observable<[ServerModel]>
}

class ApiService: ApiServiceProtocol {
    let apiProvider: ApiProviderProtocol
    let appConfiguration: AppConfigurationProviderProtocol
    
    init(apiProvider: ApiProviderProtocol, appConfiguration: AppConfigurationProviderProtocol) {
        self.apiProvider = apiProvider
        self.appConfiguration = appConfiguration
    }
    
    func authLogin(_ credentials: LoginCredentialsModel) -> Observable<AuthorizationResponse> {
        let request = AuthorizationRequest(credentials: credentials)
        return apiProvider.post(apiRequest: request)
    }
    
    func getServerList() -> Observable<[ServerModel]> {
        let request = ServerListRequest()
        return apiProvider.get(apiRequest: request)
    }
}
