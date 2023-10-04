//
//  SettingsModelMock.swift
//  UIFramework
//
//  Created by Eric Gimènez Galera on 14/9/23.
//  Copyright © 2023 eric.gimenez.galera. All rights reserved.
//

import API
import Foundation
@testable import UserInterface

class SettingsModelMock: SettingsModel {
    var getPlantDataResult: PlantDetails? = .makeStub()

    func getPlantData() async -> PlantDetails? {
        getPlantDataResult
    }

    func logout() {}
}
