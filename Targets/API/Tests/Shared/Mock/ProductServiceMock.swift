//
//  ProductServiceMock.swift
//  UIFramework
//
//  Created by Eric Gimènez Galera on 14/9/23.
//  Copyright © 2023 eric.gimenez.galera. All rights reserved.
//

import API
import Foundation

public class ProductServiceMock: ProductionService {
    public var currentProductionSuccess: Bool = true
    public var currentProductionResult: Production = .makeStub()

    public var dailyProductionSuccess: Bool = true
    public var dailyProductionResult: DailyProduction = .makeStub()

    public func currentProduction(datalogSerialNumber _: String) async throws -> Production {
        guard currentProductionSuccess else {
            throw ConnectionManagerError.invalidStatusCode(expectedStatusCodes: [200], receivedStatusCode: 401)
        }

        return currentProductionResult
    }

    public func dailyProduction(
        datalogSerialNumber _: String,
        inverterSerialNumber _: String
    ) async throws -> DailyProduction {
        guard dailyProductionSuccess else {
            throw ConnectionManagerError.invalidStatusCode(expectedStatusCodes: [200], receivedStatusCode: 401)
        }

        return dailyProductionResult
    }
}
