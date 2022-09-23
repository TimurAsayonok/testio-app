//
//  Asset.swift
//  Testio
//
//  Created by Timur Asayonok on 23/09/2022.
//

import UIKit

// MARK: Asset for Images
// Ideally to use swiftgen on production
enum Asset {
    static let unsplash = UIImage(named: "unsplash")
    static let logo = UIImage(named: "logo")
    static let personCropCircleFill = UIImage(systemName: "person.crop.circle.fill") ?? UIImage()
    static let lockCircleFill = UIImage(systemName: "lock.circle.fill") ?? UIImage()
    static let arrowUpArrowDown = UIImage(systemName: "arrow.up.arrow.down") ?? UIImage()
    static let rectanglePortraitAndArrowRight = UIImage(systemName: "rectangle.portrait.and.arrow.right") ?? UIImage()
}
