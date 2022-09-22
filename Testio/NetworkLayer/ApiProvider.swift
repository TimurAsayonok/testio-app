//
//  ApiProvider.swift
//  Testio
//
//  Created by Timur Asayonok on 19/09/2022.
//

import Foundation
import RxSwift

protocol ApiProviderProtocol {
    var basedUrl: URL { get }
    
    func send<T: RequestProtocol>(apiRequest: T, method: HTTPMethod) -> Observable<T.Response>
}

// realisation of main HTTP requests
extension ApiProviderProtocol {
    func get<T: RequestProtocol>(apiRequest: T) -> Observable<T.Response> {
        return send(apiRequest: apiRequest, method: .get)
    }
    
    func post<T: RequestProtocol>(apiRequest: T) -> Observable<T.Response> {
        return send(apiRequest: apiRequest, method: .post)
    }
    
    func put<T: RequestProtocol>(apiRequest: T) -> Observable<T.Response> {
        return send(apiRequest: apiRequest, method: .put)
    }
    
    func delete<T: RequestProtocol>(apiRequest: T) -> Observable<T.Response> {
        return send(apiRequest: apiRequest, method: .delete)
    }
}

class ApiProvider: ApiProviderProtocol {
    var basedUrl: URL {
        appConfiguration.apiBasedUrl
    }
    
    private let appConfiguration: AppConfigurationProviderProtocol
    private let urlSession: URLSession
    private let headersRequestDecorator: HeadersRequestDecoratorProtocol
    
    init(
        urlSession: URLSession,
        appConfiguration: AppConfigurationProviderProtocol,
        headersRequestDecorator: HeadersRequestDecoratorProtocol
    ) {
        self.appConfiguration = appConfiguration
        self.urlSession = urlSession
        self.headersRequestDecorator = headersRequestDecorator
    }
    
    func send<T: RequestProtocol>(apiRequest: T, method: HTTPMethod) -> Observable<T.Response> {
        var request: URLRequest
        do {
            request = try apiRequest.buildRequest(with: basedUrl, method: method)
            headersRequestDecorator.decorate(urlRequest: &request)
        } catch {
            print("🐞", type(of: self), "->", error)
            return .error(error)
        }
        
        return Observable.create { observer in
            let task = self.urlSession.dataTask(with: request) { data, response, error in
                if let error = error {
                    observer.onError(error)
                }
                
                if let httpResponse = response as? HTTPURLResponse {
                    do {
                        if 200..<300 ~= httpResponse.statusCode {
                            let model = try T.getJSONDecoder().decode(T.Response.self, from: data ?? Data())
                            
                            observer.onNext(model)
                        } else {
                            let errorMessage = try T.getJSONDecoder().decode(T.Error.self, from: data ?? Data())
                            observer.onError(errorMessage)
                        }
                    } catch {
                        print("fgdfg")
                        observer.onError(error)
                    }
                }
                
                observer.onCompleted()
            }
            
            task.resume()
            
            return Disposables.create {
                task.cancel()
            }
        }
    }
}
