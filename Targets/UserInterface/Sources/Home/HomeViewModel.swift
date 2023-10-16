//
//  HomeViewModel.swift
//  UIFramework
//
//  Created by Eric Gimènez Galera on 13/9/23.
//  Copyright © 2023 eric.gimenez.galera. All rights reserved.
//

import API
import DependencyInjection
import Foundation

class HomeViewModel: ViewModel {
    @Injected(\.homeModel) private var homeModel: HomeModel
    @Published var isLoading: Bool = true
    @Published var currentProduction: Production?
    @Published var socialContribution: SocialContribution?

    func loadProductionData(
        homeEnergyProgressVar: any SwiftUiMultiProgressView,
        solarProductionProgressVar: any SwiftUiMultiProgressView
    ) {
        let task = Task<Void, Never>.detached(priority: .background) { [weak self] in
            defer {
                DispatchQueue.main.sync { [weak self] in
                    self?.isLoading = false
                }
            }

            guard
                let socialContribution = await self?.homeModel.loadSocialContribution(),
                let dailyProduction = await self?.homeModel.loadDailyProduction(),
                let currentProduction = await self?.homeModel.loadCurrentProduction()
            else {
                return
            }
            await self?.publishDailyProduction(
                homeEnergyProgressVar: homeEnergyProgressVar,
                solarProductionProgressVar: solarProductionProgressVar,
                dailyProduction: dailyProduction
            )

            await self?.publishProductionData(
                socialContribution: socialContribution,
                currentProduction: currentProduction
            )
        }
        tasks.append(task)
    }

    @MainActor func publishDailyProduction(
        homeEnergyProgressVar: some SwiftUiMultiProgressView,
        solarProductionProgressVar: any SwiftUiMultiProgressView,
        dailyProduction: DailyProduction
    ) {
        DispatchQueue.main.async {
            homeEnergyProgressVar.updateData(
                section: HomeEnergyStorage.selfConsumed.rawValue,
                to: Float(dailyProduction.selfConsumed / dailyProduction.totalLocal)
            )
            homeEnergyProgressVar.updateData(
                section: HomeEnergyStorage.importedFromGrid.rawValue,
                to: Float(dailyProduction.importedFromGrid / dailyProduction.totalLocal)
            )

            solarProductionProgressVar.updateData(
                section: SolarProductionStorage.selfConsumed.rawValue,
                to: Float(dailyProduction.selfConsumed / dailyProduction.totalSolar)
            )
            solarProductionProgressVar.updateData(
                section: SolarProductionStorage.exportedToGrid.rawValue,
                to: Float(dailyProduction.exportedToGrid / dailyProduction.totalSolar)
            )
        }
    }

    @MainActor func publishProductionData(
        socialContribution: SocialContribution,
        currentProduction: Production
    ) {
        self.socialContribution = socialContribution
        self.currentProduction = currentProduction
    }
}