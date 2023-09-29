//
//  DISettingsModel.swift
//  UIFramework
//
//  Created by Eric Gimènez Galera on 14/9/23.
//  Copyright © 2023 eric.gimenez.galera. All rights reserved.
//

import DependencyInjection
import Foundation

private struct SettingsModelKey: InjectionKey {
    static var currentValue: SettingsModel = SettingsModelImpl()
}

extension InjectedValues {
    var settingsModel: SettingsModel {
        get { Self[SettingsModelKey.self] }
        set { Self[SettingsModelKey.self] = newValue }
    }
}
