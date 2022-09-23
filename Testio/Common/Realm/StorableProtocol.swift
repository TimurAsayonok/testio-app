//
//  StorableProtocol.swift
//  Testio
//
//  Created by Timur Asayonok on 23/09/2022.
//

import Foundation
import RealmSwift

protocol Storable {}
extension Object: Storable {}
