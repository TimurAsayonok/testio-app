//
//  UserDefaultMock.swift
//  TestioTests
//
//  Created by Timur Asayonok on 21/09/2022.
//

import Foundation

extension UserDefaults {
    static func mock(
        for functionName: StaticString = #function,
        inFile fileName: StaticString = #file
    ) -> UserDefaults {
        let className = "\(fileName)".split(separator: "/").last?.split(separator: ".").first
        let testName = "\(functionName)".split(separator: "(").first
        let suiteName = "test.\(className ?? "").\(testName ?? "")"

        let defaults = self.init(suiteName: suiteName)!
        defaults.removePersistentDomain(forName: suiteName)
        return defaults
    }
}
