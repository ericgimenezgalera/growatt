//
//  SolarProductionStorage.swift
//  UserInterface
//
//  Created by Eric Gimènez Galera on 11/10/23.
//  Copyright © 2023 eric.gimenez.galera. All rights reserved.
//

import Foundation
import UIKit

enum SolarProductionStorage: Int, ProgressViewStorageType {
    case selfConsumed, exportedToGrid

    init(rawValue: Int) {
        switch rawValue {
        case 0:
            self = .selfConsumed
        case 1:
            self = .exportedToGrid
        default:
            self = .exportedToGrid
        }
    }

    var description: String {
        switch self {
        case .selfConsumed:
            return "Self consumed"
        case .exportedToGrid:
            return "Exported to grid"
        }
    }

    var color: UIColor {
        switch self {
        case .selfConsumed:
            return UIColor.progressViewGreen
        case .exportedToGrid:
            return UIColor.progressViewBlue
        }
    }
}
