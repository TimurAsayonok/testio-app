//
//  AlertCoordinator.swift
//  Testio
//
//  Created by Timur Asayonok on 18/09/2022.
//

import UIKit

enum AlertRoute: RouteType {
    case actionSheet(title: String? = nil, message: String? = nil, actions: [UIAlertAction])
}

class AlertCoordinator: Coordinator<AlertRoute> {
    override init(route: AlertRoute) {
        super.init(route: route)
    }
    
    override func generateViewController(for route: AlertRoute) -> UIViewController {
        switch route {
        case let .actionSheet(title, message, actions):
            let actionSheet = UIAlertController(title: title, message: message, preferredStyle: .actionSheet)
            actions.forEach { actionSheet.addAction($0) }
            actionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel))
            
            return actionSheet
        }
    }
}
