//
//  PlantServiceMock.swift
//  UIFramework
//
//  Created by Eric Gimènez Galera on 14/9/23.
//  Copyright © 2023 eric.gimenez.galera. All rights reserved.
//

import API
import Foundation

public class PlantServiceMock: PlantService {
    public var success: Bool = true
    public var plantDetailsResult: PlantDetails = .makeStub()

    public func plantList() async throws -> PlantDetails {
        guard success else {
            throw ConnectionManagerError.invalidStatusCode(expectedStatusCodes: [200], receivedStatusCode: 401)
        }

        return plantDetailsResult
    }
}
