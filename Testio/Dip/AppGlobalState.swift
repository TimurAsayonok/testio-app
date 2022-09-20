//
//  AppGlobalState.swift
//  Testio
//
//  Created by Timur Asayonok on 20/09/2022.
//

import Foundation
import RxSwift
import RxCocoa

class AppGlobalState {
    private var errorSubject: PublishSubject<Error> = PublishSubject()
    var errorObserver: AnyObserver<Error> { errorSubject.asObserver() }
    var errorDriver: Driver<Error> { errorSubject.asDriver(onErrorDriveWith: .never()) }
}
