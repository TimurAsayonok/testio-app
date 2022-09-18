//
//  AlertCoordinator.swift
//  Testio
//
//  Created by Timur Asayonok on 18/09/2022.
//

import UIKit

enum AlertRoute: RouteType {
    case alert(
        title: String?,
        message: String?,
        buttonConfirmTitle: String?,
        buttonCancelTitle: String? = nil,
        confirmHandle: (() -> Void)? = nil
    )
}

class AlertCoordinator: Coordinator<AlertRoute> {
    override init(route: AlertRoute) {
        super.init(route: route)
    }
    
    override func generateViewController(for route: AlertRoute) -> UIViewController {
        switch route {
        case let .alert(title, message, buttonConfirmTitle, buttonCancelTitle, confirmHandle):
            let vc = UIAlertController(title: title ?? "Alert", message: message, preferredStyle: .alert)
            
            if let confirmTitle = buttonConfirmTitle {
                let confirmAction = UIAlertAction(title: confirmTitle, style: .default, handler: { _ in
                    confirmHandle?()
                })
                
                vc.addAction(confirmAction)
            }
            
            if let cancelTitle = buttonCancelTitle {
                let cancelAction = UIAlertAction(title: cancelTitle, style: .cancel, handler: nil)
                vc.addAction(cancelAction)
            }
            
            // add default cancel button if alert doesn't have buttons
            if vc.actions.isEmpty {
                let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
                vc.addAction(cancelAction)
            }
            
            return vc
        }
    }
}
