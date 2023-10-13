//
//  HomeEnergyStorage.swift
//  UserInterface
//
//  Created by Eric Gimènez Galera on 11/10/23.
//  Copyright © 2023 eric.gimenez.galera. All rights reserved.
//

import Foundation
import UIKit

enum HomeEnergyStorage: Int, ProgressViewStorageType {
    case selfConsumed, importedFromGrid

    init(rawValue: Int) {
        switch rawValue {
        case 0:
            self = .selfConsumed
        case 1:
            self = .importedFromGrid
        default:
            self = .importedFromGrid
        }
    }

    var description: String {
        switch self {
        case .selfConsumed:
            return "Self consumed"
        case .importedFromGrid:
            return "Imported from grid"
        }
    }

    var color: UIColor {
        switch self {
        case .selfConsumed:
            return UIColor.progressViewGreen
        case .importedFromGrid:
            return UIColor.progressViewYellow
        }
    }
}
