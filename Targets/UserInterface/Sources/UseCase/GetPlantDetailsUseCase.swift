//
//  GetPlantDetailsUseCase.swift
//  UIFramework
//
//  Created by Eric Gimènez Galera on 13/9/23.
//  Copyright © 2023 eric.gimenez.galera. All rights reserved.
//

import API
import DependencyInjection
import Foundation

// sourcery: AutoMockable
protocol GetPlantDetailsUseCase {
    func getPlantData() async -> PlantDetails?
}

class GetPlantDetailsUseCaseImpl: GetPlantDetailsUseCase {
    @Injected(\.plantService) var plantService: PlantService

    func getPlantData() async -> PlantDetails? {
        try? await plantService.plantList()
    }
}
