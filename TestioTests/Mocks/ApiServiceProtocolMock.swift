//
//  ApiServiceProtocolMock.swift
//  TestioTests
//
//  Created by Timur Asayonok on 21/09/2022.
//

@testable import Testio
import RxSwift
import Foundation

class ApiServiceProtocolMock: ApiServiceProtocol {
    func authLogin(_ credentials: LoginCredentialsModel) -> Observable<Void> {
        return Observable.just(())
    }
    
    func getServerList() -> Observable<[ServerModel]> {
        return Observable.just([ServerModel(name: "Test", distance: 2)])
    }
}
