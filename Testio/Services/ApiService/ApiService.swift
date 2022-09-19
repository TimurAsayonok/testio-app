//
//  ApiService.swift
//  Testio
//
//  Created by Timur Asayonok on 19/09/2022.
//

import Foundation
import RxSwift

protocol ApiServiceProtocol {
    func authLogin(_ credentials: LoginCredentials) -> Observable<AuthorizationResponse>
}

class ApiService: ApiServiceProtocol {
    let apiProvider: ApiProviderProtocol
    let appConfiguration: AppConfigurationProviderProtocol
    
    init(apiProvider: ApiProviderProtocol, appConfiguration: AppConfigurationProviderProtocol) {
        self.apiProvider = apiProvider
        self.appConfiguration = appConfiguration
    }
    
    func authLogin(_ credentials: LoginCredentials) -> Observable<AuthorizationResponse> {
        let request = AuthorizationRequest(credentials: credentials)
        return apiProvider.post(apiRequest: request)
            .map { response in
                print("Response: \(response)")
                return response
            }
    }
}
