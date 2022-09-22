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

// MARK: ServerListViewModel
/*
 Model for presenting list of servers on a table
 with observing filter and logout button events
 */
final class ServerListViewModel: ViewModelProtocol {
    fileprivate var disposeBag = DisposeBag()
    
    var input: Input = Input()
    var output: Output = Output()
    
    var state: State
    
    let dependencies: Dependencies
    
    init(servers: [ServerModel], dependencies: Dependencies) {
        self.dependencies = dependencies
        self.state = State(serversSubject: .init(value: servers))
        
        bindSubjects()
    }
    
    func bindSubjects() {
        // bind list of servers for preparing it to dataModel
        state.serversSubject.asObservable()
            .map { servers -> [SectionDataModel] in
                [SectionDataModel(model: .list, items: [.empty] + servers.map { .item($0) })]
            }
            .bind(to: input.dataModelsSubject)
            .disposed(by: disposeBag)
        
        // observe logout button tap event
        input.logoutSubject.asObservable()
            .subscribe(onNext: { [weak self] in
                // delete token and move to login screen
                self?.dependencies.keychainWrapper.deleteBearerToken()
                self?.dependencies.appGlobalState.screenTriggerObserver
                    .onNext(ScreenLink(StartRoute.login, presentation: .asRootView)
                )
            })
            .disposed(by: disposeBag)
        
        // observe filter button tap event and trigger for presenting ActionSheet
        input.presentFilterModalViewSubject.asObservable()
            .map { [weak self] () -> ScreenLink in
                ScreenLink(AlertRoute.actionSheet(actions: self?.setupActions() ?? []), presentation: .present)
            }
            .bind(to: dependencies.appGlobalState.screenTriggerObserver)
            .disposed(by: disposeBag)
        
        // filter list of servers based on filter type and update data model
        state.filterStatusSubject.asObservable()
            .withLatestFrom(state.serversSubject, resultSelector: { ($0, $1) })
            .flatMap { [weak self] (filter, servers) -> Observable<[ServerModel]> in
                guard let self = self else { return .never() }
                return Observable.just(self.sort(servers, by: filter))
            }
            .bind(to: state.serversSubject)
            .disposed(by: disposeBag)
    }
    
    /// Sorts list of `servers` based on `filter's` type
    /// - parameters:
    ///     - servers:  array of `servers`
    ///     - filter: type of `filter` for sorting servers
    /// - returns: Sorted list of `servers` based on `filter's` type
    ///
    private func sort(_ servers: [ServerModel], by filter: Filter = .byName) -> [ServerModel] {
        switch filter {
        case .byName: return servers.sorted { $0.name < $1.name }
        case .byDistance: return servers.sorted { $0.distance < $1.distance }
        }
    }
    
    /// Returns array of `Alert actions`
    /// - returns: Array of UIAlertAction
    private func setupActions() -> [UIAlertAction] {
        return [
            .init(
                title: HardcodedStrings.distance,
                style: .default,
                handler: { [weak self] _ in self?.state.filterStatusSubject.onNext(.byDistance)}
            ),
            .init(
                title: HardcodedStrings.alphabetical,
                style: .default,
                handler: { [weak self] _ in self?.state.filterStatusSubject.onNext(.byName)}
            )
        ]
    }
}

// MARK: SectionDataModel
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

// MARK: State & Filter
extension ServerListViewModel {
    struct State {
        var serversSubject = BehaviorSubject<[ServerModel]>(value: [])
        var filterStatusSubject = BehaviorSubject<Filter>(value: .byName)
    }
    
    enum Filter: String {
        case byName
        case byDistance
    }
}

// MARK: Input
extension ServerListViewModel {
    struct Input {
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
}

// MARK: OUTPUT
extension ServerListViewModel {
    struct Output {}
}
