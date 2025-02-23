//
//  ProgressViewStorageType.swift
//  UserInterface
//
//  Created by Eric Gimènez Galera on 11/10/23.
//  Copyright © 2023 eric.gimenez.galera. All rights reserved.
//

import Foundation
import UIKit

public protocol ProgressViewStorageType: CaseIterable {
    init(rawValue: Int)
    var rawValue: Int { get }
    var color: UIColor { get }
    var description: String { get }
}
