//
//  AppDependency.swift
//  Testio
//
//  Created by Timur Asayonok on 18/09/2022.
//

import Foundation

protocol Dependencies {
    var userDefaults: UserDefaults { get }
}

struct AppDependency: Dependencies {
    let userDefaults: UserDefaults
}
