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

class HomeViewModel: ViewModel {
    @Injected(\.homeModel) private var homeModel: HomeModel
    @Published var isLoading: Bool = true
    @Published var currentProduction: Production?
    @Published var socialContribution: SocialContribution?

    func loadProductionData(
        homeEnergyProgressBar: any SwiftUiMultiProgressView,
        solarProductionProgressBar: any SwiftUiMultiProgressView
    ) {
        let task = Task<Void, Never>.detached(priority: .background) { [weak self] in
            defer {
                DispatchQueue.main.sync { [weak self] in
                    self?.isLoading = false
                }
            }

            guard
                let (socialContribution, dailyProduction, currentProduction) = await self?.fetchData(),
                let socialContribution = socialContribution,
                let dailyProduction = dailyProduction,
                let currentProduction = currentProduction
            else {
                return
            }

            await self?.publishDailyProduction(
                homeEnergyProgressBar: homeEnergyProgressBar,
                solarProductionProgressBar: solarProductionProgressBar,
                dailyProduction: dailyProduction
            )

            await self?.publishProductionData(
                socialContribution: socialContribution,
                currentProduction: currentProduction
            )
        }
        tasks.append(task)
    }

    private func fetchData() async -> (SocialContribution?, DailyProduction?, Production?) {
        await withTaskGroup(of: DataResult.self) { [self] group -> (
            SocialContribution?,
            DailyProduction?,
            Production?
        ) in
            group.addTask {
                .socialContribution(await self.homeModel.loadSocialContribution())
            }

            group.addTask {
                .dailyProduction(await self.homeModel.loadDailyProduction())
            }

            group.addTask {
                .production(await self.homeModel.loadCurrentProduction())
            }

            var finalProduction: Production?
            var finalSocialContribution: SocialContribution?
            var finalDailyProduction: DailyProduction?

            for await value in group {
                switch value {
                case let .production(production):
                    finalProduction = production
                case let .socialContribution(socialContribution):
                    finalSocialContribution = socialContribution
                case let .dailyProduction(dailyProduction):
                    finalDailyProduction = dailyProduction
                }
            }

            return (finalSocialContribution, finalDailyProduction, finalProduction)
        }
    }

    @MainActor func publishDailyProduction(
        homeEnergyProgressBar: some SwiftUiMultiProgressView,
        solarProductionProgressBar: any SwiftUiMultiProgressView,
        dailyProduction: DailyProduction
    ) async {
        await homeEnergyProgressBar.updateData(
            section: HomeEnergyStorage.selfConsumed.rawValue,
            to: Float(dailyProduction.selfConsumed / dailyProduction.totalLocal)
        )
        await homeEnergyProgressBar.updateData(
            section: HomeEnergyStorage.importedFromGrid.rawValue,
            to: Float(dailyProduction.importedFromGrid / dailyProduction.totalLocal)
        )

        await solarProductionProgressBar.updateData(
            section: SolarProductionStorage.selfConsumed.rawValue,
            to: Float(dailyProduction.selfConsumed / dailyProduction.totalSolar)
        )
        await solarProductionProgressBar.updateData(
            section: SolarProductionStorage.exportedToGrid.rawValue,
            to: Float(dailyProduction.exportedToGrid / dailyProduction.totalSolar)
        )
    }

    @MainActor func publishProductionData(
        socialContribution: SocialContribution,
        currentProduction: Production
    ) async {
        self.socialContribution = socialContribution
        self.currentProduction = currentProduction
    }
}
