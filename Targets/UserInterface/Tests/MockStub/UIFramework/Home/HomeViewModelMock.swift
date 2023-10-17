//
//  HomeViewModelMock.swift
//  UserInterfaceTests
//
//  Created by Eric Gimènez Galera on 16/10/23.
//  Copyright © 2023 eric.gimenez.galera. All rights reserved.
//

import Foundation
@testable import UserInterface

class HomeViewModelMock: HomeViewModel {
    var loadProductionDataCalled: Bool = false
    var loadProductionDataParameters: (SwiftUiMultiProgressView, SwiftUiMultiProgressView)?

    override func loadProductionData(
        homeEnergyProgressBar: SwiftUiMultiProgressView,
        solarProductionProgressBar: SwiftUiMultiProgressView
    ) {
        loadProductionDataCalled = true
        loadProductionDataParameters = (homeEnergyProgressBar, solarProductionProgressBar)
    }
}
