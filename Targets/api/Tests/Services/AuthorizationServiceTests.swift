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
    private let loginPath = "newTwoLoginAPI.do"
    private let fakeUser = "fakeUser"
    private let fakePassword = "fakePassword"

    func testSuccess() async throws {
        // MARK: Given

        let expectedAuthenticationResult = AuthenticationResult.makeStub()

        let mockedData = try JSONEncoder().encode(expectedAuthenticationResult)
        stubResponse(subpath: loginPath, statusCode: 200, data: [.post: mockedData])

        // MARK: WHEN

        let authenticationResult = try await connectionManager
            .authorise(authentication: Authentication(username: fakeUser, password: fakePassword))

        // MARK: THEN

        XCTAssertEqual(expectedAuthenticationResult, authenticationResult)
    }

    func testInvalidUserOrPassword() async throws {
        // MARK: Given

        let expectedAuthenticationResult = AuthenticationResult.makeStub(
            authenticationResultDetails: AuthenticationResultDetails(
                success: false,
                data: nil
            )
        )

        let mockedData = try JSONEncoder().encode(expectedAuthenticationResult)
        stubResponse(subpath: loginPath, statusCode: 200, data: [.post: mockedData])

        // MARK: WHEN

        do {
            _ = try await connectionManager
                .authorise(authentication: Authentication(username: fakeUser, password: fakePassword))
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
