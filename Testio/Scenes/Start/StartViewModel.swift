//
//  StartViewModel.swift
//  Testio
//
//  Created by Timur Asayonok on 19/09/2022.
//

import Foundation

final class StartViewModel: ViewModelProtocol {
    var input: Input = Input()
    var output: Output = Output()
    
    let dependencies: Dependencies
    
    init(dependencies: Dependencies) {
        self.dependencies = dependencies
    }
}

extension StartViewModel {
    struct Input {}
    struct Output {}
}
