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
    private let plantServicePath = "panel/getDevicesByPlantList"

    override func setUp() {
        super.setUp()
        addPlantIdCookie()
    }

    func testListSuccess() async throws {
        // MARK: Given

        let expectedPlantDetails = PlantDetails.makeStub()
        let expectedData = PlantListResponse(result: 1, obj: PlantListResponseDetails(datas: [expectedPlantDetails]))

        let mockedData = try JSONEncoder().encode(expectedData)
        stubResponse(subpath: plantServicePath, statusCode: 200, data: [.post: mockedData])

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
        stubResponse(subpath: plantServicePath, statusCode: 200, data: [.post: mockedData])

        // MARK: WHEN

        try await assertThrowsAsyncError(await connectionManager.plantList()) { error in
            XCTAssertEqual(error as? PlantServiceError, PlantServiceError.noPlantId)
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
        stubResponse(subpath: plantServicePath, statusCode: 200, data: [.post: mockedData])

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
        stubResponse(subpath: plantServicePath, statusCode: 200, data: [.post: mockedData])

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
        stubResponse(subpath: plantServicePath, statusCode: 200, data: [.post: mockedData])

        // MARK: WHEN

        try await assertThrowsAsyncError(await connectionManager.plantList()) { error in
            XCTAssertEqual(error as? PlantServiceError, PlantServiceError.noPlanDetails)
        }
    }
}
