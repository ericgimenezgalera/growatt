//
//  PlantService.swift
//  api
//
//  Created by Eric Gimenez on 14/6/22.
//  Copyright © 2022 eric.gimenez.galera. All rights reserved.
//

import Foundation

public enum PlantServiceError: Error {
    case noPlantId
    case multiplePlantDetails
    case noPlanDetails
}

public protocol PlantService {
    func plantList() async throws -> PlantDetails
    func socialContribution() async throws -> SocialContribution
}

extension ConnectionManager: PlantService {
    public func plantList() async throws -> PlantDetails {
        let plantListRequest = try PlantListRequest()
        let plantListResponse: PlantListResponse = try await ConnectionManager.Builder(self)
            .addUrlSubPath(path: "panel/getDevicesByPlantList")
            .httpMethod(.post)
            .encodeParameterInURL(parameter: plantListRequest, includeBody: false)
            .validStatusCode(200)
            .doRequest()

        guard plantListResponse.result == 1 else {
            throw ConnectionManagerError.invalidStatusCode(expectedStatusCodes: [200], receivedStatusCode: 401)
        }
        guard plantListResponse.obj.datas.count <= 1 else {
            throw PlantServiceError.multiplePlantDetails
        }

        guard let details = plantListResponse.obj.datas.first else {
            throw PlantServiceError.noPlanDetails
        }

        return details
    }

    public func socialContribution() async throws -> SocialContribution {
        let socialContributionRequest = try SocialContributionRequest()
        let socialContributionResponse: SocialContributionResponse = try await ConnectionManager.Builder(self)
            .addUrlSubPath(path: "panel/getPlantData")
            .httpMethod(.post)
            .encodeParameterInURL(parameter: socialContributionRequest, includeBody: false)
            .validStatusCode(200)
            .doRequest()

        guard socialContributionResponse.result == 1 else {
            throw ConnectionManagerError.invalidStatusCode(expectedStatusCodes: [200], receivedStatusCode: 401)
        }

        return socialContributionResponse.obj
    }
}
