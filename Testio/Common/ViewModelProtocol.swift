//
//  ViewModelProtocol.swift
//  Testio
//
//  Created by Timur Asayonok on 19/09/2022.
//

import Foundation

protocol ViewModelProtocol {
    associatedtype Input
    associatedtype Output
    
    var input: Input { get }
    var output: Output { get }
}
