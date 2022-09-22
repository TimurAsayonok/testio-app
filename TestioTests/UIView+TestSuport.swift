//
//  UIView+TestSuport.swift
//  TestioTests
//
//  Created by Timur Asayonok on 21/09/2022.
//

import UIKit
import XCTest

extension UIView {
    func embedIntoMainApplicationWindow(file: StaticString = #file, line: UInt = #line) {
        var keyWindow: UIWindow?
        
        if #available(iOS 15, *) {
            keyWindow = UIApplication.shared.connectedScenes
                .filter({$0.activationState == .foregroundActive })
                .first(where: { $0 is UIWindowScene })
                .flatMap({ $0 as? UIWindowScene })?.windows
                .first(where: \.isKeyWindow)
        } else {
            keyWindow = UIApplication.shared.windows.filter({$0.isKeyWindow}).first
        }
        
        guard let keyWindow = keyWindow else {
            XCTFail("Testing environment does not have a key window", file: file, line: line)
            return
        }

        guard let controller = keyWindow.rootViewController else {
            XCTFail("Key window in test does not have a root view controller", file: file, line: line)
            return
        }

        controller.view.addSubview(self)
    }
}
