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
    public var plantListSuccess: Bool = true
    public var plantDetailsResult: PlantDetails = .makeStub()

    public var socialContributionSuccess: Bool = true
    public var socialContributionResult: SocialContribution = .makeStub()

    public func plantList() async throws -> PlantDetails {
        guard plantListSuccess else {
            throw ConnectionManagerError.invalidStatusCode(expectedStatusCodes: [200], receivedStatusCode: 401)
        }

        return plantDetailsResult
    }

    public func socialContribution() async throws -> SocialContribution {
        guard socialContributionSuccess else {
            throw ConnectionManagerError.invalidStatusCode(expectedStatusCodes: [200], receivedStatusCode: 401)
        }

        return socialContributionResult
    }
}
