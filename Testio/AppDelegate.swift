//
//  AppDelegate.swift
//  Testio
//
//  Created by Timur Asayonok on 15/09/2022.
//

import UIKit
import Dip
import IQKeyboardManagerSwift

#if DEBUG
    import netfox
#endif

class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    
    private var coordinator: AppCoordinator!
    private var dipContainer: DependencyContainer!
    private var keychainWrapper: KeychainWrapperProtocol!
    
    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        // Global Appearances
        AppearanceGlobal.setupNavigationBar()
        
        // Keyboard Setting for working with Forms
        IQKeyboardManager.shared.enable = true
        IQKeyboardManager.shared.previousNextDisplayMode = .alwaysHide
        IQKeyboardManager.shared.keyboardDistanceFromTextField = 100
        IQKeyboardManager.shared.toolbarTintColor = UIColor.black
        IQKeyboardManager.shared.toolbarDoneBarButtonItemText = HardcodedStrings.done
        
        // Netfox - for observing api calls
        #if DEBUG
            NFX.sharedInstance().start()
        #endif
        
        // DIP
        dipContainer = DipContainerBuilder.build()
        keychainWrapper = try? dipContainer.resolve()
        
        // AppCoordinator
        window = UIWindow()
        let appCoordinatorFactory: AppCoordinatorFactory! = try? dipContainer.resolve()
        coordinator = appCoordinatorFactory.create()
        coordinator.setRoot(for: window!) // swiftlint:disable:this force_unwrapping
        coordinator.boot()

        return true
    }
}
