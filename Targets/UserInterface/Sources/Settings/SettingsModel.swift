//
//  SettingsModel.swift
//  UIFramework
//
//  Created by Eric Gimènez Galera on 13/9/23.
//  Copyright © 2023 eric.gimenez.galera. All rights reserved.
//

import API
import DependencyInjection
import Foundation

protocol SettingsModel {
    func logout()
    func getPlantData() async -> PlantDetails?
}

class SettingsModelImpl: SettingsModel {
    @Injected(\.sessionManager) var sessionManager: SessionManager
    @Injected(\.plantService) var plantService: PlantService

    func logout() {
        sessionManager.logout()
    }

    func getPlantData() async -> PlantDetails? {
        do {
            return try await plantService.plantList()
        } catch {
            return nil
        }
    }
}
