//
//  ServerListRealmRepositoryProtocolMock.swift
//  TestioTests
//
//  Created by Timur Asayonok on 23/09/2022.
//

@testable import Testio
import Foundation
import RxSwift

// MARK: ServerListRealmRepositoryProtocolMock
// contains methods for working getting servers from Realm DB
class ServerListRealmRepositoryProtocolMock: ServerListRealmRepositoryProtocol {
    func saveServerList(_ list: [ServerModel]) {}
    func getServerList() -> Observable<[ServerModel]> {
        return Observable.just([ServerModel.mock])
    }
}

