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
    
    init(urlSession: URLSession, appConfiguration: AppConfigurationProviderProtocol) {
        self.appConfiguration = appConfiguration
        self.urlSession = urlSession
    }
    
    func send<T: RequestProtocol>(apiRequest: T, method: HTTPMethod) -> Observable<T.Response> {
        var request: URLRequest
        do {
            request = try apiRequest.buildRequest(with: basedUrl, method: method)
            // TODO: ADD heade
            request.addValue("Bearer f9731b590611a5a9377fbd02f247fcdf", forHTTPHeaderField: "Authorization")
        } catch {
            print("🐞", type(of: self), "->", error)
            return .error(error)
        }
        
        return Observable.create { observer in
            let task = self.urlSession.dataTask(with: request) { data, response, error in
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
