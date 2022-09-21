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
    
    var state: State = State()
    
    let dependencies: Dependencies
    
    init(dependencies: Dependencies) {
        self.dependencies = dependencies
        
        bindSubjects()
        
//        input.submitFormObserver.onNext(())
    }
    
    func bindSubjects() {
        input.submitFormSubject
            .wrapService(
                loadingObserver: output.loadingSubject.asObserver(),
                errorObserver: output.errorSubject.asObserver(),
                serviceMethod: dependencies.apiService.getServerList
            )
            .subscribe(onNext: { [weak self] serverList in
                let dataModel = [
                    SectionDataModel(
                        model: .list,
                        items: [.empty] + serverList.map { .item($0) }
                    )
                ]
                print("Response:", serverList)
                self?.input.dataModelsSubject.onNext(dataModel)
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
        
    }
}

extension ServerListViewModel {
    struct Input {
        fileprivate var dataModelsSubject: BehaviorSubject<[SectionDataModel]> = BehaviorSubject(value: [])
        var dataModelsDriver: Driver<[SectionDataModel]> {
            dataModelsSubject.asDriver(onErrorJustReturn: [])
        }
        
        
        fileprivate var submitFormSubject = PublishSubject<Void>()
        var submitFormObserver: AnyObserver<Void> { submitFormSubject.asObserver() }
    }
}

extension ServerListViewModel {
    struct Output {
        fileprivate var loadingSubject = BehaviorSubject<Bool>(value: false)
        var loadingDriver: Driver<Bool> {
            loadingSubject.distinctUntilChanged().asDriver(onErrorJustReturn: false)
        }

        fileprivate var errorSubject: PublishSubject<Error> = PublishSubject()
        var errorObservable: Observable<Error> { errorSubject.asObservable() }
    }
}
