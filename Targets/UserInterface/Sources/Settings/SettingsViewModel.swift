//
//  SettingsViewModel.swift
//  UIFramework
//
//  Created by Eric Gimènez Galera on 13/9/23.
//  Copyright © 2023 eric.gimenez.galera. All rights reserved.
//

import API
import DependencyInjection
import Foundation

class SettingsViewModel: ViewModel {
    @Injected(\.settingsModel) private var settingsModel: SettingsModel
    @Published var plantDetails: PlantDetails?

    func logout(navigationViewModel: NavigationViewModel) {
        let task = Task<Void, Never>.detached(priority: .background) { [weak self] in
            self?.settingsModel.logout()

            await navigationViewModel.navigate(route: SettingsNavigationRoute.onLogout)
        }
        tasks.append(task)
    }

    func getPlantData() {
        guard plantDetails == nil else {
            return
        }

        let task = Task<Void, Never>.detached(priority: .background) { [weak self] in
            guard let plantDetails = await self?.settingsModel.getPlantData() else {
                return
            }

            await self?.publishPlantDetails(plantDetails)
        }
        tasks.append(task)
    }

    @MainActor func publishPlantDetails(_ plantDetails: PlantDetails) {
        self.plantDetails = plantDetails
    }
}
