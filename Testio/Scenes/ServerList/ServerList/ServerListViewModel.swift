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
                return [
                    SectionDataModel(
                        model: .list,
                        items: [.empty] + servers.map { .item($0) }
                    )
                ]
            }
            .bind(to: input.dataModelsSubject)
            .disposed(by: disposeBag)
        
//        input.submitFormSubject
//            .wrapService(
//                loadingObserver: output.loadingSubject.asObserver(),
//                errorObserver: output.errorSubject.asObserver(),
//                serviceMethod: dependencies.apiService.getServerList
//            )
//            .subscribe(onNext: { [weak self] serverList in
//                let dataModel = [
//                    SectionDataModel(
//                        model: .list,
//                        items: [.empty] + serverList.map { .item($0) }
//                    )
//                ]
//                print("Response:", serverList)
//                self?.input.dataModelsSubject.onNext(dataModel)
//            })
//            .disposed(by: disposeBag)
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
        
        fileprivate var dataModelsSubject: BehaviorSubject<[SectionDataModel]> = BehaviorSubject(value: [])
        var dataModelsDriver: Driver<[SectionDataModel]> {
            dataModelsSubject.asDriver(onErrorJustReturn: [])
        }
        
        
        fileprivate var submitFormSubject = PublishSubject<Void>()
        var submitFormObserver: AnyObserver<Void> { submitFormSubject.asObserver() }
    }
    
    struct Output {
        fileprivate var loadingSubject = BehaviorSubject<Bool>(value: false)
        var loadingDriver: Driver<Bool> {
            loadingSubject.distinctUntilChanged().asDriver(onErrorJustReturn: false)
        }

        fileprivate var errorSubject: PublishSubject<Error> = PublishSubject()
        var errorObservable: Observable<Error> { errorSubject.asObservable() }
    }
}
