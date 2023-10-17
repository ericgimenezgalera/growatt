//
//  SettingsViewModelMock.swift
//  UserInterfaceTests
//
//  Created by Eric Gimènez Galera on 16/10/23.
//  Copyright © 2023 eric.gimenez.galera. All rights reserved.
//

import Foundation
@testable import UserInterface

class SettingsViewModelMock: SettingsViewModel {
    var logoutCalled: Bool = false
    var logoutParameters: NavigationViewModel?

    var getPlantDataCalled: Bool = false

    override func logout(navigationViewModel: NavigationViewModel) {
        logoutCalled = true
        logoutParameters = navigationViewModel
    }

    override func getPlantData() {
        getPlantDataCalled = true
    }
}
