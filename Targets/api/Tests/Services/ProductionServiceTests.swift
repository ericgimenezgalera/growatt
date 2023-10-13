//
//  ProductionServiceTests.swift
//  APITests
//
//  Created by Eric Gimenez on 15/6/22.
//  Copyright © 2022 eric.gimenez.galera. All rights reserved.
//

@testable import API
import Foundation
import Mocker
import XCTest

final class ProductionServiceTests: BaseTests {
    private let productionServicePath = "panel/singleBackflow/getSingleBackflowStatusData"
    private let datalogSerialNumber = "Fake datalog serial"

    override func setUp() {
        super.setUp()
        cleanAllCookies()
        PlantIdManager.plantId = ""
        addPlantIdCookie()
    }

    func testCurrentProductionSuccess() async throws {
        // MARK: Given

        let expectedProduction = Production.makeStub()
        let expectedData = CurrentProductionResponse(result: 1, obj: expectedProduction)

        let mockedData = try JSONEncoder().encode(expectedData)
        stubResponse(subpath: productionServicePath, statusCode: 200, data: [.post: mockedData])

        // MARK: WHEN

        let production = try await connectionManager.currentProduction(datalogSerialNumber: datalogSerialNumber)

        XCTAssertEqual(production, expectedProduction)
    }

    func testCurrentProductionFailedReasonNoPlantId() async throws {
        cleanAllCookies()

        // MARK: Given

        let expectedProduction = Production.makeStub()
        let expectedData = CurrentProductionResponse(result: 1, obj: expectedProduction)

        let mockedData = try JSONEncoder().encode(expectedData)
        stubResponse(subpath: productionServicePath, statusCode: 200, data: [.post: mockedData])

        // MARK: WHEN

        try await assertThrowsAsyncError(
            await connectionManager
                .currentProduction(datalogSerialNumber: datalogSerialNumber)
        ) { error in
            XCTAssertEqual(error as? PlantIdManagerError, PlantIdManagerError.noPlantIdInCookies)
        }
    }

    func testListFailedInavildResult() async throws {
        // MARK: Given

        let expectedProduction = Production.makeStub()
        let expectedData = CurrentProductionResponse(result: -1, obj: expectedProduction)

        let mockedData = try JSONEncoder().encode(expectedData)
        stubResponse(subpath: productionServicePath, statusCode: 200, data: [.post: mockedData])

        // MARK: WHEN

        try await assertThrowsAsyncError(
            await connectionManager
                .currentProduction(datalogSerialNumber: datalogSerialNumber)
        ) { error in
            XCTAssertEqual(
                error as? ConnectionManagerError,
                ConnectionManagerError.invalidStatusCode(expectedStatusCodes: [200], receivedStatusCode: 401)
            )
        }
    }
}
