//
//  ServerListRealmRepository.swift
//  Testio
//
//  Created by Timur Asayonok on 23/09/2022.
//

import Foundation
import RealmSwift
import RxSwift

// MARK: ServerListRealmRepository
// Contains method for working with realm data manage
protocol ServerListRealmRepositoryProtocol {
    func saveServerList(_ list: [ServerModel])
    func getServerList() -> Observable<[ServerModel]>
}

class ServerListRealmRepository: ServerListRealmRepositoryProtocol {
    let realmDataManager: RealmDataManagerProtocol!
    
    init(realmDataManager: RealmDataManagerProtocol) {
        self.realmDataManager = realmDataManager
    }
    
    func saveServerList(_ list: [ServerModel]) {
        DispatchQueue.main.async { [weak self] in
            do {
                try self?.realmDataManager.save(object: ServerListRealmModel.makeListFrom(servers: list))
            } catch { print("😱", error.localizedDescription) }
        }
    }
    
    func getServerList() -> Observable<[ServerModel]> {
        return realmDataManager.fetchFirst(ServerListRealmModel.self, predicate: nil, sorted: nil)
            .map { (realmList) -> [ServerModel] in
                guard let realmList = realmList else { return [] }
                return realmList.items.map({ ServerModel.mapFromRealmModel($0) })
            }
    }
}
