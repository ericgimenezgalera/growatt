//
//  AuthorizationServiceTests.swift
//  APITests
//
//  Created by Eric Gimenez on 15/6/22.
//  Copyright © 2022 eric.gimenez.galera. All rights reserved.
//

@testable import API
import Foundation
import Mocker
import XCTest

final class AuthorizationServiceTests: BaseTests {
    private let loginPath = "login"
    private let fakeUser = "fakeUser"
    private let fakePassword = "fakePassword"

    func testSuccess() async throws {
        // MARK: Given

        let expectedAuthenticationResult = AuthenticationResult.makeStub()

        let mockedData = try JSONEncoder().encode(expectedAuthenticationResult)
        stubResponse(subpath: loginPath, statusCode: 200, data: [.post: mockedData])

        // MARK: WHEN

        try await connectionManager
            .authorise(authentication: AuthenticationRequest(account: fakeUser, password: fakePassword))
    }

    func testInvalidUserOrPassword() async throws {
        // MARK: Given

        let expectedAuthenticationResult = AuthenticationResult.makeStub(-1)

        let mockedData = try JSONEncoder().encode(expectedAuthenticationResult)
        stubResponse(subpath: loginPath, statusCode: 200, data: [.post: mockedData])

        // MARK: WHEN

        do {
            _ = try await connectionManager
                .authorise(authentication: AuthenticationRequest(account: fakeUser, password: fakePassword))
            XCTFail("Exception not thrown out")
        } catch {
            // MARK: THEN

            if let error = error as? ConnectionManagerError {
                XCTAssertEqual(error, .invalidStatusCode(expectedStatusCodes: [200], receivedStatusCode: 401))
            } else {
                XCTFail("Invalid error")
            }
        }
    }
}
