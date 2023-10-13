//
//  UIView+CustomAnchor.swift
//  UserInterface
//
//  Created by Eric Gimènez Galera on 11/10/23.
//  Copyright © 2023 eric.gimenez.galera. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
    @discardableResult
    func anchor(
        top: NSLayoutYAxisAnchor? = nil,
        left: NSLayoutXAxisAnchor? = nil,
        bottom: NSLayoutYAxisAnchor? = nil,
        right: NSLayoutXAxisAnchor? = nil,
        paddingTop: CGFloat = 0,
        paddingLeft: CGFloat = 0,
        paddingBottom: CGFloat = 0,
        paddingRight: CGFloat = 0,
        width: CGFloat = 0,
        height: CGFloat = 0,
        centerX: NSLayoutXAxisAnchor? = nil
    ) -> [NSLayoutConstraint] {
        translatesAutoresizingMaskIntoConstraints = false

        var anchors = [NSLayoutConstraint]()

        if let top = top {
            anchors.append(topAnchor.constraint(equalTo: top, constant: paddingTop))
        }
        if let left = left {
            anchors.append(leftAnchor.constraint(equalTo: left, constant: paddingLeft))
        }
        if let bottom = bottom {
            anchors.append(bottomAnchor.constraint(equalTo: bottom, constant: -paddingBottom))
        }
        if let right = right {
            anchors.append(rightAnchor.constraint(equalTo: right, constant: -paddingRight))
        }
        if width > 0 {
            anchors.append(widthAnchor.constraint(equalToConstant: width))
        }
        if height > 0 {
            anchors.append(heightAnchor.constraint(equalToConstant: height))
        }
        if let centerX = centerX {
            anchors.append(centerXAnchor.constraint(equalTo: centerX, constant: 0))
        }

        anchors.forEach { $0.isActive = true }

        return anchors
    }
}
