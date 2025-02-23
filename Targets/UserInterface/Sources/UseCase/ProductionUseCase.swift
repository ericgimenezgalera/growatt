//
//  ProductionUseCase.swift
//  UIFramework
//
//  Created by Eric Gimènez Galera on 13/9/23.
//  Copyright © 2023 eric.gimenez.galera. All rights reserved.
//

import API
import DependencyInjection
import Foundation

// sourcery: AutoMockable
protocol ProductionUseCase {
    func loadSocialContribution() async -> SocialContribution?
    func loadCurrentProduction() async -> Production?
    func loadDailyProduction() async -> DailyProduction?
}

class ProductionUseCaseImpl: ProductionUseCase {
    @Injected(\.productionService) var productionService: ProductionService
    @Injected(\.plantService) var plantService: PlantService

    func loadSocialContribution() async -> SocialContribution? {
        return try? await plantService.socialContribution()
    }

    func loadCurrentProduction() async -> Production? {
        do {
            let plantDetails = try await plantService.plantList()
            return try await productionService
                .currentProduction(datalogSerialNumber: plantDetails.datalogSerialNumber)
        } catch {
            return nil
        }
    }

    func loadDailyProduction() async -> DailyProduction? {
        do {
            let plantDetails = try await plantService.plantList()
            return try await productionService.dailyProduction(
                datalogSerialNumber: plantDetails.datalogSerialNumber,
                inverterSerialNumber: plantDetails.inverterSerialNumber
            )
        } catch {
            return nil
        }
    }
}
