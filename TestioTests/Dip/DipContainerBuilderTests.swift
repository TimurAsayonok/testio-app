//
//  DipContainerBuilderTests.swift
//  TestioTests
//
//  Created by Timur Asayonok on 22/09/2022.
//

@testable import Testio
import Dip
import XCTest

class DipContainerBuilderTests: XCTestCase {
    var sut: DependencyContainer!
    
    override func setUp() {
        super.setUp()
        sut = DipContainerBuilder.build()
    }
    
    func testDependencyModel() {
        XCTAssertNotNil(try? sut.resolve() as UserDefaults)
        XCTAssertNotNil(try? sut.resolve() as AppGlobalState)
        XCTAssertNotNil((try? sut.resolve() as KeychainWrapperProtocol) as? KeychainWrapper)
        XCTAssertNotNil((try? sut.resolve() as AppConfigurationProviderProtocol) as? AppConfigurationProvider)
        XCTAssertNotNil((try? sut.resolve() as AppConfigurationProviderProtocol) as? AppConfigurationProvider)
        XCTAssertNotNil((try? sut.resolve() as Dependencies) as? AppDependency)
    }
    
    func testFactoryModel() {
        XCTAssertNotNil(try? sut.resolve() as AppCoordinatorFactory)
        XCTAssertNotNil(try? sut.resolve() as FatCoordinatorFactory)
    }
    
    func testNetworkModule() {
        XCTAssertNotNil((try? sut.resolve() as HeadersRequestDecoratorProtocol) as? HeadersRequestDecorator)
        XCTAssertNotNil((try? sut.resolve() as ApiProviderProtocol) as? ApiProvider)
        XCTAssertNotNil(try? sut.resolve() as URLSession)
    }
    
    func testServiceModule() {
        XCTAssertNotNil((try? sut.resolve() as ApiServiceProtocol) as? ApiService)
    }
}
