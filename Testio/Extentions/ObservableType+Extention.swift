//
//  ObservableType+Extention.swift
//  Testio
//
//  Created by Timur Asayonok on 20/09/2022.
//

import Foundation
import RxSwift

public extension ObservableType {
    func wrapService<R>(
        loadingObserver: AnyObserver<Bool>?,
        errorObserver: AnyObserver<Error>?,
        serviceMethod: @escaping (Element) -> Observable<R>
    ) -> Observable<R> {
        flatMap { parameters -> Observable<Event<R>> in
            loadingObserver?.onNext(true)
            return serviceMethod(parameters).materialize()
        }
        .flatMap { event -> Observable<R> in
            loadingObserver?.onNext(false)
            switch event {
            case let .next(element):
                return .just(element)

            case let .error(error):
                errorObserver?.onNext(error)
                return .never()

            case .completed:
                return .never()
            }
        }
    }
}
