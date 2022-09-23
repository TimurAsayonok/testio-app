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
        guard let realm = realm, let object = object as? Object else { throw RealmError.realmIsNil }
        
        try realm.write {
            realm.add(object)
        }
    }
    
    func delete(object: Storable) throws {
        guard let realm = realm, let object = object as? Object else { throw RealmError.realmIsNil }
        
        try realm.write {
            realm.delete(object)
        }
    }
    
    func fetch<T>(_ model: T.Type, predicate: NSPredicate?, sorted: Sorted?) -> Observable<[T?]> where T : Storable {
        guard let realm = realm, let model = model as? Object.Type else {
            return .error(RealmError.realmIsNil)
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
    
//    func fetch<T>(
//        _ model: T.Type,
//        predicate: NSPredicate?,
//        sorted: Sorted?,
//        completion: (([T?]) -> Void)
//    ) where T: Storable {
//        guard let realm = realm, let model = model as? Object.Type else { return }
//
//        var objects = realm.objects(model)
//
//        if let predicate = predicate {
//            objects = objects.filter(predicate)
//        }
//
//        if let sorted = sorted {
//            objects = objects.sorted(byKeyPath: sorted.key, ascending: sorted.ascending)
//        }
//
//        completion(objects.compactMap { $0 as? T })
//    }
    
//    func fetchFirst<T>(
//        _ model: T.Type,
//        predicate: NSPredicate?,
//        sorted: Sorted?,
//        completion: ((T?) -> Void)
//    ) where T: Storable {
//        fetch(model, predicate: predicate, sorted: sorted) {
//            completion($0.first ?? nil)
//        }
//    }
}

enum RealmError: Error {
    case realmIsNil
}
