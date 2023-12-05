//
//  PlantServiceTests.swift
//  APITests
//
//  Created by Eric Gimenez on 15/6/22.
//  Copyright © 2022 eric.gimenez.galera. All rights reserved.
//

@testable import API
import Foundation
import Mocker
import XCTest

final class PlantServiceTests: BaseTests {
    private let plantListPath = "panel/getDevicesByPlantList"
    private let socialContributionPath = "panel/getPlantData"

    override func setUp() {
        super.setUp()
        cleanAllCookies()
        PlantIdManager.plantId = ""
        addPlantIdCookie()
    }

    func testListSuccess() async throws {
        // MARK: Given

        let expectedPlantDetails = PlantDetails.makeStub()
        let expectedData = PlantListResponse(result: 1, obj: PlantListResponseDetails(datas: [expectedPlantDetails]))

        let mockedData = try JSONEncoder().encode(expectedData)
        stubResponse(subpath: plantListPath, statusCode: 200, data: [.post: mockedData])

        // MARK: WHEN

        let plantDetails = try await connectionManager.plantList()

        XCTAssertEqual(plantDetails, expectedPlantDetails)
    }

    func testListFailedReasonNoPlantId() async throws {
        cleanAllCookies()

        // MARK: Given

        let expectedPlantDetails = PlantDetails.makeStub()
        let expectedData = PlantListResponse(result: 1, obj: PlantListResponseDetails(datas: [expectedPlantDetails]))

        let mockedData = try JSONEncoder().encode(expectedData)
        stubResponse(subpath: plantListPath, statusCode: 200, data: [.post: mockedData])

        // MARK: WHEN

        try await assertThrowsAsyncError(await connectionManager.plantList()) { error in
            XCTAssertEqual(error as? PlantIdManagerError, PlantIdManagerError.noPlantIdInCookies)
        }
    }

    func testListFailedMoreThanOnePlant() async throws {
        // MARK: Given

        let expectedPlantDetails = PlantDetails.makeStub()
        let expectedData = PlantListResponse(
            result: 1,
            obj: PlantListResponseDetails(datas: [expectedPlantDetails, expectedPlantDetails])
        )

        let mockedData = try JSONEncoder().encode(expectedData)
        stubResponse(subpath: plantListPath, statusCode: 200, data: [.post: mockedData])

        // MARK: WHEN

        try await assertThrowsAsyncError(await connectionManager.plantList()) { error in
            XCTAssertEqual(error as? PlantServiceError, PlantServiceError.multiplePlantDetails)
        }
    }

    func testListFailedInavildResult() async throws {
        // MARK: Given

        let expectedPlantDetails = PlantDetails.makeStub()
        let expectedData = PlantListResponse(
            result: -1,
            obj: PlantListResponseDetails(datas: [expectedPlantDetails, expectedPlantDetails])
        )

        let mockedData = try JSONEncoder().encode(expectedData)
        stubResponse(subpath: plantListPath, statusCode: 200, data: [.post: mockedData])

        // MARK: WHEN

        try await assertThrowsAsyncError(await connectionManager.plantList()) { error in
            XCTAssertEqual(
                error as? ConnectionManagerError,
                ConnectionManagerError.invalidStatusCode(expectedStatusCodes: [200], receivedStatusCode: 401)
            )
        }
    }

    func testListFailedNoPlantDetails() async throws {
        // MARK: Given

        let expectedData = PlantListResponse(result: 1, obj: PlantListResponseDetails(datas: []))

        let mockedData = try JSONEncoder().encode(expectedData)
        stubResponse(subpath: plantListPath, statusCode: 200, data: [.post: mockedData])

        // MARK: WHEN

        try await assertThrowsAsyncError(await connectionManager.plantList()) { error in
            XCTAssertEqual(error as? PlantServiceError, PlantServiceError.noPlanDetails)
        }
    }

    func testSocialContributionSuccess() async throws {
        // MARK: Given

        let expectedSocialContribution = SocialContribution.makeStub()
        let expectedData = SocialContributionResponse(result: 1, obj: expectedSocialContribution)

        let mockedData = try JSONEncoder().encode(expectedData)
        stubResponse(subpath: socialContributionPath, statusCode: 200, data: [.post: mockedData])

        // MARK: WHEN

        let socialContribution = try await connectionManager.socialContribution()

        XCTAssertEqual(socialContribution, expectedSocialContribution)
    }

    func testSocialContributionFailedReasonNoPlantId() async throws {
        cleanAllCookies()

        // MARK: Given

        let expectedSocialContribution = SocialContribution.makeStub()
        let expectedData = SocialContributionResponse(result: 1, obj: expectedSocialContribution)

        let mockedData = try JSONEncoder().encode(expectedData)
        stubResponse(subpath: socialContributionPath, statusCode: 200, data: [.post: mockedData])

        // MARK: WHEN

        try await assertThrowsAsyncError(await connectionManager.socialContribution()) { error in
            XCTAssertEqual(error as? PlantIdManagerError, PlantIdManagerError.noPlantIdInCookies)
        }
    }

    func testSocialContributionFailedInavildResult() async throws {
        // MARK: Given

        let expectedSocialContribution = SocialContribution.makeStub()
        let expectedData = SocialContributionResponse(result: -1, obj: expectedSocialContribution)

        let mockedData = try JSONEncoder().encode(expectedData)
        stubResponse(subpath: socialContributionPath, statusCode: 200, data: [.post: mockedData])

        // MARK: WHEN

        try await assertThrowsAsyncError(await connectionManager.socialContribution()) { error in
            XCTAssertEqual(
                error as? ConnectionManagerError,
                ConnectionManagerError.invalidStatusCode(expectedStatusCodes: [200], receivedStatusCode: 401)
            )
        }
    }
}
