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
import UIKit

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
                [SectionDataModel(model: .list, items: [.empty] + servers.map { .item($0) })]
            }
            .bind(to: input.dataModelsSubject)
            .disposed(by: disposeBag)
        
        input.prepareDataModelSubject.asObservable()
            .map { servers -> [SectionDataModel] in
                [SectionDataModel(model: .list, items: [.empty] + servers.map { .item($0) })]
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
        
        input.presentFilterModalViewSubject.asObservable()
            .map { [weak self] () -> ScreenLink in
                ScreenLink(AlertRoute.actionSheet(actions: self?.setupActions() ?? []), presentation: .present)
            }
            .bind(to: dependencies.appGlobalState.screenTriggerObserver)
            .disposed(by: disposeBag)
        
        state.filterStatusSubject.asObservable()
            .flatMap { [weak self] filter -> Observable<[ServerModel]> in
                guard let self = self else { return .never() }
                return Observable.just(self.sortServers(by: filter))
            }
            .bind(to: input.prepareDataModelSubject)
            .disposed(by: disposeBag)
    }
    
    private func sortServers(by filter: Filter = .byName) -> [ServerModel] {
        switch filter {
        case .byName: return state.servers.sorted { $0.name < $1.name }
        case .byDistance: return state.servers.sorted { $0.distance < $1.distance }
        }
    }
    
    private func setupActions() -> [UIAlertAction] {
        return [
            .init(
                title: "By distance",
                style: .default,
                handler: { [weak self] _ in self?.state.filterStatusSubject.onNext(.byDistance)}
            ),
            .init(
                title: "Alphabetical",
                style: .default,
                handler: { [weak self] _ in self?.state.filterStatusSubject.onNext(.byName)}
            )
        ]
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
        var filterStatusSubject = BehaviorSubject<Filter>(value: .byName)
    }
    
    enum Filter: String {
        case byName
        case byDistance
    }
}

extension ServerListViewModel {
    struct Input {
        fileprivate var startSubject = PublishSubject<Void>()
        var startObserver: AnyObserver<Void> { startSubject.asObserver() }
        var startDriver: Driver<Void> { startSubject.asDriver(onErrorDriveWith: .just(())) }
        
        fileprivate var prepareDataModelSubject: BehaviorSubject<[ServerModel]> = BehaviorSubject(value: [])
        
        fileprivate var dataModelsSubject: BehaviorSubject<[SectionDataModel]> = BehaviorSubject(value: [])
        var dataModelsObserver: AnyObserver<[SectionDataModel]> { dataModelsSubject.asObserver() }
        var dataModelsDriver: Driver<[SectionDataModel]> { dataModelsSubject.asDriver(onErrorJustReturn: []) }
        
        fileprivate var logoutSubject = PublishSubject<Void>()
        var logoutObserver: AnyObserver<Void> { logoutSubject.asObserver() }
        var logoutDriver: Driver<Void> { logoutSubject.asDriver(onErrorDriveWith: .just(())) }
        
        fileprivate var presentFilterModalViewSubject = PublishSubject<Void>()
        var presentFilterModalViewObserver: AnyObserver<Void> { presentFilterModalViewSubject.asObserver() }
        var presentFilterModalViewDriver: Driver<Void> {
            presentFilterModalViewSubject.asDriver(onErrorDriveWith: .just(()))
        }
    }
    
    struct Output {}
}
