//
//  AppGlobalState.swift
//  Testio
//
//  Created by Timur Asayonok on 20/09/2022.
//

import Foundation
import RxSwift
import RxCocoa

// MARK: AppGlobalState
// Contains global Subjects what can be observed from any places in the app
class AppGlobalState {
    // PublishSubject for handling errors
    private var errorSubject: PublishSubject<Error> = PublishSubject()
    var errorObserver: AnyObserver<Error> { errorSubject.asObserver() }
    var errorDriver: Driver<Error> { errorSubject.asDriver(onErrorDriveWith: .never()) }
    
    // PublishSubject for handling screen triggering
    private var screenTriggerSubject: PublishSubject<ScreenLink?> = PublishSubject()
    var screenTriggerObserver: AnyObserver<ScreenLink?> { screenTriggerSubject.asObserver() }
    var screenTriggerObservable: Observable<ScreenLink?> { screenTriggerSubject.asObservable() }
}
