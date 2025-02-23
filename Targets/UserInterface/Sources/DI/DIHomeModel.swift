//
//  DIHomeModel.swift
//  UIFramework
//
//  Created by Eric Gimènez Galera on 14/9/23.
//  Copyright © 2023 eric.gimenez.galera. All rights reserved.
//

import DependencyInjection
import Foundation

private struct ProductionUseCaseKey: InjectionKey {
    static var currentValue: ProductionUseCase = ProductionUseCaseImpl()
}

extension InjectedValues {
    var productionUseCase: ProductionUseCase {
        get { Self[ProductionUseCaseKey.self] }
        set { Self[ProductionUseCaseKey.self] = newValue }
    }
}
