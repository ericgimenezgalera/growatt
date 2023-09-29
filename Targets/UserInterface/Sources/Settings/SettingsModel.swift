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
}

class SettingsModelImpl: SettingsModel {
    @Injected(\.sessionManager) var sessionManager: SessionManager

    func logout() {
        sessionManager.logout()
    }
}
