//
//  AppDelegate.swift
//  Testio
//
//  Created by Timur Asayonok on 15/09/2022.
//

import UIKit
import Dip

#if DEBUG
    import netfox
#endif

class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    
    private var coordinator: AppCoordinator!
    private var dipContainer: DependencyContainer!
    
    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        // Override point for customization after application launch.
        
        // Netfox
        #if DEBUG
            NFX.sharedInstance().start()
        #endif
        
        // DIP
        dipContainer = DipContainerBuilder.build()
        
        window = UIWindow()
        let appCoordinatorFactory: AppCoordinatorFactory! = try? dipContainer.resolve()
        coordinator = appCoordinatorFactory.create()
        coordinator.setRoot(for: window!) // swiftlint:disable:this force_unwrapping
        coordinator.boot()

        return true
    }
}
