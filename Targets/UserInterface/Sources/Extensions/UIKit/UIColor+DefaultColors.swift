//
//  UIColor+DefaultColors.swift
//  UserInterface
//
//  Created by Eric Gimènez Galera on 11/10/23.
//  Copyright © 2023 eric.gimenez.galera. All rights reserved.
//

import Foundation
import UIKit

extension UIColor {
    static let progressViewGreen = UIColor.rgb(red: 67, green: 213, blue: 82)
    static let progressViewYellow = UIColor.rgb(red: 252, green: 196, blue: 9)
    static let progressViewBlue = UIColor.rgb(red: 10, green: 96, blue: 253)
    static let progressViewBackground = UIColor.rgb(red: 224, green: 224, blue: 224)

    static func rgb(red: CGFloat, green: CGFloat, blue: CGFloat) -> UIColor {
        return UIColor(red: red / 255, green: green / 255, blue: blue / 255, alpha: 1)
    }
}
