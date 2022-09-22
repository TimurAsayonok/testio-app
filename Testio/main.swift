//
//  main.swift
//  Testio
//
//  Created by Timur Asayonok on 18/09/2022.
//

import UIKit

//UIApplicationMain(
//    CommandLine.argc,
//    CommandLine.unsafeArgv,
//    nil,
//    NSStringFromClass(AppDelegate.self)
//)

let appDelegateClass: AnyClass = NSClassFromString("AppDelegateMock") ?? AppDelegate.self

UIApplicationMain(
    CommandLine.argc,
    CommandLine.unsafeArgv,
    nil,
    NSStringFromClass(appDelegateClass)
)
