//
//  HomeModelMock.swift
//  Growatt
//
//  Created by Eric Gimènez Galera on 13/10/23.
//  Copyright © 2023 eric.gimenez.galera. All rights reserved.
//

import API
import Foundation
@testable import UserInterface

class HomeModelMock: HomeModel {
    var loadSocialContributionResult: SocialContribution? = .makeStub()
    var loadCurrentProductionResult: Production? = .makeStub()
    var loadDailyProductionResult: DailyProduction = .makeStub()

    func loadSocialContribution() async -> SocialContribution? {
        loadSocialContributionResult
    }

    func loadCurrentProduction() async -> Production? {
        loadCurrentProductionResult
    }

    func loadDailyProduction() async -> DailyProduction? {
        loadDailyProductionResult
    }
}
