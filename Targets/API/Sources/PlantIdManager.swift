//
//  PlantIdManager.swift
//  UserInterface
//
//  Created by Eric Gimènez Galera on 11/10/23.
//  Copyright © 2023 eric.gimenez.galera. All rights reserved.
//

import Foundation
import SwiftUI

enum PlantIdManagerError: Error {
    case noPlantIdInCookies
}

enum PlantIdManager {
    @AppStorage("PlantId")
    static var plantId: String = ""

    static func obtain() throws -> String {
        guard !plantId.isEmpty else {
            let cookies = HTTPCookieStorage.shared.cookies?.filter { cookie in
                cookie.name == "onePlantId"
            }

            guard cookies?.count == 1, let plantId = cookies?.first?.value else {
                throw PlantIdManagerError.noPlantIdInCookies
            }
            Self.plantId = plantId

            return Self.plantId
        }

        return plantId
    }
}
