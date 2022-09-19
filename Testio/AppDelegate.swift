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
        // Keyboard Setting for working with Forms
        let keyBoardManagerShared = IQKeyboardManager.shared
        keyBoardManagerShared.enable = true
        keyBoardManagerShared.previousNextDisplayMode = .alwaysHide
        keyBoardManagerShared.keyboardDistanceFromTextField = 30
        keyBoardManagerShared.toolbarTintColor = UIColor.black
        keyBoardManagerShared.toolbarDoneBarButtonItemText = HardcodedStrings.done.rawValue
        
        // Netfox
        #if DEBUG
            NFX.sharedInstance().start()
        #endif
        
        // DIP
        dipContainer = DipContainerBuilder.build()
        
        // Keychain
        keychainWrapper = try? dipContainer.resolve()
        
        window = UIWindow()
        let appCoordinatorFactory: AppCoordinatorFactory! = try? dipContainer.resolve()
        coordinator = appCoordinatorFactory.create()
        coordinator.setRoot(for: window!) // swiftlint:disable:this force_unwrapping
        coordinator.boot()

        return true
    }
}
