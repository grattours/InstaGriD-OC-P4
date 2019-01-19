//
//  extensions.swift
//  InstaGriD-OC-P5
//
//  Created by Luc Derosne on 19/01/2019.
//  Copyright © 2019 Luc Derosne. All rights reserved.
//

import Foundation
import UIKit
// convertit une vue en image, élégant non ?
extension UIView {
    var image: UIImage? {
        let renderer = UIGraphicsImageRenderer(bounds: bounds)
        return renderer.image { rendererContext in layer.render(in: rendererContext.cgContext) }
    }
}
