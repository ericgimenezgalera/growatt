//
//  DIGetPlantDetailsUseCase.swift
//  UIFramework
//
//  Created by Eric Gimènez Galera on 14/9/23.
//  Copyright © 2023 eric.gimenez.galera. All rights reserved.
//

import DependencyInjection
import Foundation

private struct GetPlantDetailsUseCaseKey: InjectionKey {
    static var currentValue: GetPlantDetailsUseCase = GetPlantDetailsUseCaseImpl()
}

extension InjectedValues {
    var getPlantDetailsUseCase: GetPlantDetailsUseCase {
        get { Self[GetPlantDetailsUseCaseKey.self] }
        set { Self[GetPlantDetailsUseCaseKey.self] = newValue }
    }
}
