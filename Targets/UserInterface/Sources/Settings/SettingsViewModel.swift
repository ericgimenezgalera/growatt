//
//  SettingsViewModel.swift
//  UIFramework
//
//  Created by Eric Gimènez Galera on 13/9/23.
//  Copyright © 2023 eric.gimenez.galera. All rights reserved.
//

import DependencyInjection
import Foundation

class SettingsViewModel: ViewModel {
    @Injected(\.settingsModel) private var settingsModel: SettingsModel
    @Published var isLoading: Bool = true

    func logout(navigationViewModel: NavigationViewModel) {
        let task = Task.detached(priority: .background) { [weak self] in
            self?.settingsModel.logout()
                
            await navigationViewModel.cleanStackAndNavigate(route: SettingsNavigationRoute.onLogout)
        }
        tasks.append(task)
    }
}
