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
import SwiftUI

public class SettingsViewModel: SettingsView.Output {
    @Injected(\.logoutUseCase) private var logoutUseCase: LogoutUseCase
    @Injected(\.getPlantDetailsUseCase) private var getPlantDetailsUseCase: GetPlantDetailsUseCase
    @AppStorage(usernameUserDefaultsKey) var username: String = ""

    let navigationViewModel: NavigationViewModel
    public let viewState: SettingsView.ViewState

    public init(navigationViewModel: NavigationViewModel) {
        self.navigationViewModel = navigationViewModel
        viewState = .init(
            username: "",
            logoutViewState: .init(buttonId: SettingsConstants.logoutId)
        )
        viewState.output = self
        viewState.logoutViewState.action = { [weak self] in
            await self?.logout()
        }
        viewState.username = username
    }

    func onAppear() async {
        guard viewState.plantDetails == nil, let plantDetails = await getPlantDetailsUseCase.getPlantData() else {
            return
        }

        await publishPlantDetails(plantDetails)
    }

    func logout() async {
        logoutUseCase.logout()

        await navigationViewModel.navigate(route: SettingsNavigationRoute.onLogout)
    }

    @MainActor
    func publishPlantDetails(_ plantDetails: PlantDetails) async {
        viewState.plantDetails = plantDetails
    }
}
