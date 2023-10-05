//
//  ProductionStub.swift
//  APITests
//
//  Created by Eric Gimenez on 15/6/22.
//  Copyright © 2022 eric.gimenez.galera. All rights reserved.
//

@testable import API
import Foundation

extension Production {
    static func makeStub() -> Production {
        Production(
            totalSolar: 999_999_999,
            exportToGrid: 987_654_321,
            importFromGrid: 123_456_789,
            useInLocal: 888_888_888
        )
    }
}
