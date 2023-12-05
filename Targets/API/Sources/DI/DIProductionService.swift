//
//  DIProductionService.swift
//  UIFramework
//
//  Created by Eric Gimènez Galera on 14/9/23.
//  Copyright © 2023 eric.gimenez.galera. All rights reserved.
//

import DependencyInjection
import Foundation

private struct ProductionServiceKey: InjectionKey {
    static var currentValue: ProductionService = ConnectionManager.shared
}

public extension InjectedValues {
    var productionService: ProductionService {
        get { Self[ProductionServiceKey.self] }
        set { Self[ProductionServiceKey.self] = newValue }
    }
}
