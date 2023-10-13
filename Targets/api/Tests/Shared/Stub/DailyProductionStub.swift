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
            totalSolar: 12345,
            selfConsumed: 22222,
            exportedToGrid: 33333,
            importedFromGrid: 44444,
            totalLocal: 98765
        )
    }
}
