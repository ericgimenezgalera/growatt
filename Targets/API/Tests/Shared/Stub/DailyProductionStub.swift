//
//  DailyProductionStub.swift
//  APITests
//
//  Created by Eric Gimenez on 15/6/22.
//  Copyright © 2022 eric.gimenez.galera. All rights reserved.
//

@testable import API
import Foundation

extension DailyProduction {
    static func makeStub() -> DailyProduction {
        DailyProduction(
            totalSolar: 2000,
            selfConsumed: 1000,
            exportedToGrid: 1000,
            importedFromGrid: 600,
            totalLocal: 1600
        )
    }
}
