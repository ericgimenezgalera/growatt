//
//  DIPlantService.swift
//  UIFramework
//
//  Created by Eric Gimènez Galera on 14/9/23.
//  Copyright © 2023 eric.gimenez.galera. All rights reserved.
//

import DependencyInjection
import Foundation

private struct PlantServiceKey: @preconcurrency InjectionKey {
    @MainActor static var currentValue: PlantService = ConnectionManager.shared
}

public extension InjectedValues {
    var plantService: PlantService {
        get { Self[PlantServiceKey.self] }
        set { Self[PlantServiceKey.self] = newValue }
    }
}
