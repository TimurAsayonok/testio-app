//
//  AppDelegateMock.swift
//  TestioTests
//
//  Created by Timur Asayonok on 21/09/2022.
//
import UIKit

@objc(AppDelegateMock)
class AppDelegateMock: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    
    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil
    ) -> Bool {
        let rootViewController = UIViewController(nibName: nil, bundle: nil)
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = rootViewController
        window?.makeKeyAndVisible()
        
        print("🧪: AppDelegateMock")
        
        return true
    }
}
