//
//  ScreenLink.swift
//  Testio
//
//  Created by Timur Asayonok on 21/09/2022.
//

import Foundation

struct ScreenLink {
    var route: RouteType
    var presentation: ScreenLink.Presentation
    
    init(_ route: RouteType, presentation: ScreenLink.Presentation) {
        self.route = route
        self.presentation = presentation
    }
    
    enum Presentation: Equatable {
        case present
        case asRootView
        case asRootNavigation
    }
}
