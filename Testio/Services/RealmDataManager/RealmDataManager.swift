//
//  RealmDataManager.swift
//  Testio
//
//  Created by Timur Asayonok on 23/09/2022.
//

import Foundation
import RxSwift
import RealmSwift

protocol RealmDataManagerProtocol {
    func save(object: Storable) throws
    func delete(object: Storable) throws
    func deleteAll() throws
    func fetch<T: Storable>(
        _ model: T.Type, predicate: NSPredicate?, sorted: Sorted?
    ) -> Observable<[T?]>
    func fetchFirst<T: Storable>(
        _ model: T.Type, predicate: NSPredicate?, sorted: Sorted?
    ) -> Observable<T?>
}

class RealmDataManage: RealmDataManagerProtocol {
    private let realm: Realm?
    
    init() {
        self.realm = try? Realm(configuration: Realm.Configuration(schemaVersion: 1))
    }
    
    func save(object: Storable) throws {
        guard let realm = realm, let object = object as? Object else { throw RealmError.saveError }
        
        try realm.write {
            realm.add(object)
        }
    }
    
    func delete(object: Storable) throws {
        guard let realm = realm, let object = object as? Object else { throw RealmError.realmOrObjectIsNil }
        
        try realm.write {
            realm.delete(object)
        }
    }
    
    func deleteAll() throws {
        guard let realm = realm else { throw RealmError.deleteAllError }
        try realm.write {
            realm.deleteAll()
        }
    }
    
    func fetch<T>(_ model: T.Type, predicate: NSPredicate?, sorted: Sorted?) -> Observable<[T?]> where T : Storable {
        guard let realm = realm, let model = model as? Object.Type else {
            return .error(RealmError.realmOrObjectIsNil)
        }
        
        var objects = realm.objects(model)
        
        if let predicate = predicate {
            objects = objects.filter(predicate)
        }
        
        if let sorted = sorted {
            objects = objects.sorted(byKeyPath: sorted.key, ascending: sorted.ascending)
        }
        
        return .just(objects.compactMap({ $0 as? T }))
    }
    
    func fetchFirst<T>(_ model: T.Type, predicate: NSPredicate?, sorted: Sorted?) -> Observable<T?> where T : Storable {
        return fetch(model, predicate: predicate, sorted: sorted)
            .map { $0.compactMap({ $0 }).first }
    }
}

enum RealmError: String, Error {
    case realmOrObjectIsNil
    case saveError = "Error during saving server lists to Realm"
    case deleteAllError = "Error during deleting All Objects in a Realm"
}
