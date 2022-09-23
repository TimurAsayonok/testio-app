//
//  TestRequestMock.swift
//  TestioTests
//
//  Created by Timur Asayonok on 22/09/2022.
//

@testable import Testio
import Foundation

// MARK: Test Request + Error
struct TestRequest: RequestProtocol {
    typealias Response = TestResponse
    typealias Error = TestError

    let string: String
    let int: Int
    let bool: Bool

    var path: String {
        "/some/complicated/path"
    }
}

struct TestResponse: Codable, Equatable {
    public var id: String

    public init(id: String) {
        self.id = id
    }

    public static func == (lhs: TestResponse, rhs: TestResponse) -> Bool {
        lhs.id == rhs.id
    }
}

struct TestError: Swift.Error, Equatable, Codable {
    public let error: String

    public init(error: String = "error") {
        self.error = error
    }
}


