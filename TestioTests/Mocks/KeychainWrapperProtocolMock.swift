//
//  KeychainWrapperProtocolMock.swift
//  TestioTests
//
//  Created by Timur Asayonok on 21/09/2022.
//

@testable import Testio
import Foundation

class KeychainWrapperProtocolMock: KeychainWrapperProtocol {
    func setBearerToken(_ token: String?) {}
    func getBearerToken() -> String? { return "Mock Token"}
    func deleteBearerToken() {}
}

