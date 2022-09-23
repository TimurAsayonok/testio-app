//
//  ServerListRealmRepositoryTest.swift
//  TestioTests
//
//  Created by Timur Asayonok on 23/09/2022.
//

@testable import Testio
import Foundation
import XCTest
import RxSwift

class ServerListRealmRepositoryTests: XCTestCase {
    var sut: ServerListRealmRepository!
    var realmDataManager: RealmDataManagerProtocolMock!
    var disposeBag: DisposeBag!
     
    override func setUp() {
        realmDataManager = RealmDataManagerProtocolMock()
        sut = ServerListRealmRepository(
            realmDataManager: realmDataManager
        )
        disposeBag = DisposeBag()
    }
    
    func testSaveServerListAndGetServerList() {
        // delete all objects to be sure that DB is empty
        try! realmDataManager.deleteAll()
        
        let list = [ServerModel.mock]
        
        try! sut.realmDataManager.save(object: ServerListRealmModel.makeListFrom(servers: list))
        realmDataManager.fetchFirst(ServerListRealmModel.self, predicate: nil, sorted: nil)
            .subscribe(onNext: {
                XCTAssertNotNil($0)
            })
            .disposed(by: disposeBag)
    }
}
