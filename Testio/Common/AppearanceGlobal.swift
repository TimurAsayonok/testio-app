//
//  AppearanceGlobal.swift
//  Testio
//
//  Created by Timur Asayonok on 21/09/2022.
//

import Foundation
import UIKit

struct AppearanceGlobal {
    static func setupNavigationBar() {
        let appearance = UINavigationBar.appearance()

        if #available(iOS 15.0, *) { // apply fix for iOS 15 ignoring barTintColor
            let navigationBarAppearance = Self.getDefaultNavigationBarAppearance()

            appearance.standardAppearance = navigationBarAppearance
            appearance.scrollEdgeAppearance = navigationBarAppearance
        }
    }
    
    static func getDefaultNavigationBarAppearance() -> UINavigationBarAppearance {
        let navigationBarAppearance = UINavigationBarAppearance()
        navigationBarAppearance.backgroundColor = .white
        
        return navigationBarAppearance
    }
}
