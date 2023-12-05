//
//  ConnectionManagerTests.swift
//  APITests
//
//  Created by Eric Gimenez on 16/6/22.
//  Copyright © 2022 eric.gimenez.galera. All rights reserved.
//

import Alamofire
@testable import API
import DependencyInjection
import Foundation
import Mocker
import XCTest

final class ConnectionManagerTests: BaseTests {
    private let fakePath = "fake/path"
    private let fakeToken = "fakeToken"
    private let fakeServerId = "1234567890"

    func testSuccessConnection() async throws {
        // MARK: Given

        let expectedAuthenticationResult = AuthenticationResult.makeStub()
        let mockedData = try JSONEncoder().encode(expectedAuthenticationResult)

        stubResponse(subpath: fakePath, statusCode: 200, data: [.get: mockedData])

        let request = try URLRequest(url: URL(string: "https://\(Self.host)/\(fakePath)")!, method: .get)

        // MARK: WHEN

        let authenticationResult: AuthenticationResult = try await connectionManager.doRequest(
            validStatusCodes: [200],
            request: request
        )

        // MARK: THEN

        XCTAssertEqual(expectedAuthenticationResult, authenticationResult)
    }

    func testInternalError() async throws {
        // MARK: Given

        let expectedAuthenticationResult = AuthenticationResult.makeStub()
        let mockedData = try JSONEncoder().encode(expectedAuthenticationResult)

        stubResponse(subpath: fakePath, statusCode: 200, data: [.get: mockedData])

        let request = try URLRequest(url: URL(string: "https://\(Self.host)/\(fakePath)")!, method: .get)

        // MARK: WHEN

        do {
            _ = try await connectionManager.doRequest(
                validStatusCodes: [200],
                request: request
            ) as String
            XCTFail("Exception not thrown out")
        } catch {
            // MARK: THEN

            if let error = error as? ConnectionManagerError {
                XCTAssertEqual(error, .internalError(AFError.responseSerializationFailed(reason: .inputFileNil)))
            } else {
                XCTFail("Invalid error")
            }
        }
    }

    func testCheckInvalidStatusCodes() async throws {
        // MARK: Given

        let expectedAuthenticationResult = AuthenticationResult.makeStub()
        let mockedData = try JSONEncoder().encode(expectedAuthenticationResult)

        stubResponse(subpath: fakePath, statusCode: 304, data: [.get: mockedData])

        let request = try URLRequest(url: URL(string: "https://\(Self.host)/\(fakePath)")!, method: .get)

        // MARK: WHEN

        do {
            _ = try await connectionManager.doRequest(
                validStatusCodes: [400, 404],
                request: request
            ) as AuthenticationResult
            XCTFail("Exception not thrown out")
        } catch {
            // MARK: THEN

            if let error = error as? ConnectionManagerError {
                XCTAssertEqual(error, .invalidStatusCode(expectedStatusCodes: [400, 404], receivedStatusCode: 304))
            } else {
                XCTFail("Invalid error")
            }
        }
    }

    func testCheckValidStatusCodes() async throws {
        // MARK: Given

        let expectedAuthenticationResult = AuthenticationResult.makeStub()
        let mockedData = try JSONEncoder().encode(expectedAuthenticationResult)

        stubResponse(subpath: fakePath, statusCode: 404, data: [.get: mockedData])

        let request = try URLRequest(url: URL(string: "https://\(Self.host)/\(fakePath)")!, method: .get)

        // MARK: WHEN

        let authenticationResult: AuthenticationResult = try await connectionManager.doRequest(
            validStatusCodes: [400, 404],
            request: request
        )

        // MARK: THEN

        XCTAssertEqual(expectedAuthenticationResult, authenticationResult)
    }
}
