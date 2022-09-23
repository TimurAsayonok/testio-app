//
//  MappableModelProtocol.swift
//  Testio
//
//  Created by Timur Asayonok on 23/09/2022.
//

import Foundation

protocol MappableModelProtocol {
    associatedtype RealmModel: Storable
    
    func mapToRealmModel() -> RealmModel
    static func mapFromRealmModel(_ model: RealmModel) -> Self
}
