//
//  ServiceListViewModel.swift
//  Testio
//
//  Created by Timur Asayonok on 20/09/2022.
//

import Foundation
import RxSwift
import RxDataSources
import RxCocoa

final class ServerListViewModel: ViewModelProtocol {
    fileprivate var disposeBag = DisposeBag()
    
    var input: Input = Input()
    var output: Output = Output()
    
    var state: State
    
    let dependencies: Dependencies
    
    init(servers: [ServerModel], dependencies: Dependencies) {
        self.dependencies = dependencies
        self.state = State(servers: servers)
        
        bindSubjects()
    }
    
    func bindSubjects() {
        input.startSubject.asObservable()
            .withLatestFrom(Observable.just(state.servers))
            .map { servers -> [SectionDataModel] in
                [SectionDataModel(model: .list, items: [.empty] + servers.map { .item($0) }
                    )
                ]
            }
            .bind(to: input.dataModelsSubject)
            .disposed(by: disposeBag)
        
        input.logoutSubject.asObservable()
            .subscribe(onNext: { [weak self] in
                // delete token and move to login screen
                self?.dependencies.keychainWrapper.deleteBearerToken()
                self?.dependencies.appGlobalState.screenTriggerObserver
                    .onNext(ScreenLink(StartRoute.login, presentation: .asRootView)
                )
            })
            .disposed(by: disposeBag)
    }
}

extension ServerListViewModel {
    typealias SectionDataModel = SectionModel<Section, DataModel>

    enum Section: Equatable {
        case list
    }

    enum DataModel: Equatable {
        case empty
        case item(ServerModel)
    }
}

extension ServerListViewModel {
    struct State {
        var servers: [ServerModel] = []
    }
}

extension ServerListViewModel {
    struct Input {
        fileprivate var startSubject = PublishSubject<Void>()
        var startObserver: AnyObserver<Void> { startSubject.asObserver() }
        var startDriver: Driver<Void> { startSubject.asDriver(onErrorDriveWith: .just(())) }
        
        fileprivate var dataModelsSubject: BehaviorSubject<[SectionDataModel]> = BehaviorSubject(value: [])
        var dataModelsObserver: AnyObserver<[SectionDataModel]> { dataModelsSubject.asObserver() }
        var dataModelsDriver: Driver<[SectionDataModel]> { dataModelsSubject.asDriver(onErrorJustReturn: []) }
        
        fileprivate var logoutSubject = PublishSubject<Void>()
        var logoutObserver: AnyObserver<Void> { logoutSubject.asObserver() }
        var logoutDriver: Driver<Void> { logoutSubject.asDriver(onErrorDriveWith: .just(())) }
    }
    
    struct Output {}
}
