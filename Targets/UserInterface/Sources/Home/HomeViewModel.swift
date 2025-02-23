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

private enum DataResult {
    case socialContribution(SocialContribution?)
    case dailyProduction(DailyProduction?)
    case production(Production?)
}

public class HomeViewModel: HomeView.Output {
    @Injected(\.productionUseCase) private var productionUseCase: ProductionUseCase
    public let viewState: HomeView.ViewState

    public init() {
        viewState = .init()
        viewState.output = self
    }

    @MainActor
    func loadData() async {
        viewState.isLoading = true
        defer {
            viewState.isLoading = false
        }

        guard
            let socialContribution = await productionUseCase.loadSocialContribution(),
            let dailyProduction = await productionUseCase.loadDailyProduction(),
            let currentProduction = await productionUseCase.loadCurrentProduction()
        else {
            return
        }

        await publishDailyProduction(dailyProduction: dailyProduction)
        await publishProductionData(
            socialContribution: socialContribution,
            currentProduction: currentProduction
        )
    }

    @MainActor
    func publishDailyProduction(
        dailyProduction: DailyProduction
    ) async {
        await viewState.homeEnergyProgressBarViewState.updateData(
            section: HomeEnergyStorage.selfConsumed.rawValue,
            to: Float(dailyProduction.selfConsumed / dailyProduction.totalLocal)
        )
        await viewState.homeEnergyProgressBarViewState.updateData(
            section: HomeEnergyStorage.importedFromGrid.rawValue,
            to: Float(dailyProduction.importedFromGrid / dailyProduction.totalLocal)
        )

        await viewState.solarProductionProgressBarViewState.updateData(
            section: SolarProductionStorage.selfConsumed.rawValue,
            to: Float(dailyProduction.selfConsumed / dailyProduction.totalSolar)
        )
        await viewState.solarProductionProgressBarViewState.updateData(
            section: SolarProductionStorage.exportedToGrid.rawValue,
            to: Float(dailyProduction.exportedToGrid / dailyProduction.totalSolar)
        )
    }

    @MainActor func publishProductionData(
        socialContribution: SocialContribution,
        currentProduction: Production
    ) async {
        viewState.socialContribution = socialContribution
        viewState.currentProduction = currentProduction
    }
}
