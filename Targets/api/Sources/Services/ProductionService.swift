//
//  ProductionService.swift
//  API
//
//  Created by Eric Gimènez Galera on 5/10/23.
//  Copyright © 2023 eric.gimenez.galera. All rights reserved.
//

import Foundation

public enum ProductionServiceError: Error, Equatable {
    case noPlantId
    case invalidProductionValue(_ value: String)
}

public protocol ProductionService {
    func currentProduction(datalogSerialNumber: String) async throws -> Production
}

extension ConnectionManager: ProductionService {
    public func currentProduction(datalogSerialNumber: String) async throws -> Production {
        let currentProductionRequest = try CurrentProductionRequest(datalogSerialNumber: datalogSerialNumber)

        let currentProductionResponse: CurrentProductionResponse = try await ConnectionManager.Builder(self)
            .addUrlSubPath(path: "panel/singleBackflow/getSingleBackflowStatusData")
            .httpMethod(.post)
            .encodeParameterInURL(parameter: currentProductionRequest, includeBody: false)
            .validStatusCode(200)
            .doRequest()

        guard currentProductionResponse.result == 1 else {
            throw ConnectionManagerError.invalidStatusCode(expectedStatusCodes: [200], receivedStatusCode: 401)
        }

        return currentProductionResponse.obj
    }
}
