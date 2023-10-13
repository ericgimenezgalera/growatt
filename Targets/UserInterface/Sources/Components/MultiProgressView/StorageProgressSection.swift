//
//  StorageProgressSection.swift
//  UserInterface
//
//  Created by Eric Gimènez Galera on 11/10/23.
//  Copyright © 2023 eric.gimenez.galera. All rights reserved.
//

import Foundation
import MultiProgressView
import UIKit

class StorageProgressSection: ProgressViewSection {
    private let rightBorder: UIView = {
        let border = UIView()
        border.backgroundColor = .white
        return border
    }()

    func configure(withStorageType storageType: any ProgressViewStorageType) {
        addSubview(rightBorder)
        rightBorder.anchor(top: topAnchor, bottom: bottomAnchor, right: rightAnchor, width: 1)
        backgroundColor = storageType.color
    }
}
