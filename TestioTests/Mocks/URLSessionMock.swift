//
//  URLSessionMock.swift
//  TestioTests
//
//  Created by Timur Asayonok on 22/09/2022.
//

import Foundation

class URLSessionMock: URLSession {
    typealias CompletionHandler = (Data?, URLResponse?, Error?) -> Void

    // Properties that enable us to set exactly what data or error
    // we want our mocked URLSession to return for any request.
    var data: Data?
    var response: HTTPURLResponse?
    var error: Error?

    override func dataTask(with request: URLRequest, completionHandler: @escaping CompletionHandler) -> URLSessionDataTask {
        let data = self.data
        let response = self.response
        let error = self.error

        return URLSessionDataTaskMock {
            completionHandler(data, response, error)
        }
    }

    override func dataTask(with url: URL, completionHandler: @escaping CompletionHandler) -> URLSessionDataTask {
        let data = self.data
        let response = self.response
        let error = self.error

        return URLSessionDataTaskMock {
            completionHandler(data, response, error)
        }
    }
}

// We create a partial mock by subclassing the original class
class URLSessionDataTaskMock: URLSessionDataTask {
    private let closure: () -> Void

    init(closure: @escaping () -> Void) {
        self.closure = closure
    }

    // We override the 'resume' method and simply call our closure
    // instead of actually resuming any task.
    override func resume() {
        closure()
    }

    override func cancel() {}
}

extension HTTPURLResponse {
    static func mock(_ statusCode: Int, _ headerFields: [String: String] = [:]) -> HTTPURLResponse {
        HTTPURLResponse(url: URL.mock, statusCode: statusCode, httpVersion: nil, headerFields: headerFields)!
    }
}

extension URL {
    static var mock: Self {
        URL(string: "www://url.com")!
    }
}
