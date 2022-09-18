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

@main
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

    // MARK: UISceneSession Lifecycle
    func application(
        _ application: UIApplication,
        configurationForConnecting connectingSceneSession: UISceneSession,
        options: UIScene.ConnectionOptions
    ) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running,
        // this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }
}
