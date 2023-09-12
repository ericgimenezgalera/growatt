//
//  ConnectionManagerTests.swift
//  APITests
//
//  Created by Eric Gimenez on 16/6/22.
//  Copyright © 2022 eric.gimenez.galera. All rights reserved.
//

@testable import API
import Foundation
import OHHTTPStubs
import XCTest

final class ConnectionManagerTests: BaseTests {
    private let fakePath = "/fake/path"
    private let fakeToken = "fakeToken"
    private let fakeServerId = "1234567890"

    func testSuccessConnection() async throws {
        // MARK: Given

        let expectedAuthenticationResult = AuthenticationResult.makeStub()
        try stubResponse(
            condition: isHost(Self.host) && isPath(fakePath),
            response: JSONEncoder().encode(expectedAuthenticationResult),
            code: 200
        )

        let request = try URLRequest(url: URL(string: "https://\(Self.host)\(fakePath)")!, method: .get)

        // MARK: WHEN

        let authenticationResult: AuthenticationResult = try await connectionManager.doRequest(
            validStatusCodes: [200],
            useAuthentication: false,
            request: request
        )

        // MARK: THEN

        XCTAssertEqual(expectedAuthenticationResult, authenticationResult)
    }

    func testInternalError() async throws {
        // MARK: Given

        let expectedAuthenticationResult = AuthenticationResult.makeStub()
        try stubResponse(
            condition: isHost(Self.host) && isPath(fakePath),
            response: JSONEncoder().encode(expectedAuthenticationResult),
            code: 200
        )

        let request = try URLRequest(url: URL(string: "https://\(Self.host)\(fakePath)")!, method: .get)

        // MARK: WHEN

        do {
            _ = try await connectionManager.doRequest(
                validStatusCodes: [200],
                useAuthentication: false,
                request: request
            ) as String
            XCTFail("Exception not thrown out")
        } catch {
            // MARK: THEN

            if let error = error as? ConnectionManagerError {
                XCTAssertEqual(error, .internalError)
            } else {
                XCTFail("Invalid error")
            }
        }
    }

    func testCheckInvalidStatusCodes() async throws {
        // MARK: Given

        let expectedAuthenticationResult = AuthenticationResult.makeStub()
        try stubResponse(
            condition: isHost(Self.host) && isPath(fakePath),
            response: JSONEncoder().encode(expectedAuthenticationResult),
            code: 304
        )

        let request = try URLRequest(url: URL(string: "https://\(Self.host)\(fakePath)")!, method: .get)

        // MARK: WHEN

        do {
            _ = try await connectionManager.doRequest(
                validStatusCodes: [400, 404],
                useAuthentication: false,
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
        try stubResponse(
            condition: isHost(Self.host) && isPath(fakePath),
            response: JSONEncoder().encode(expectedAuthenticationResult),
            code: 404
        )

        let request = try URLRequest(url: URL(string: "https://\(Self.host)\(fakePath)")!, method: .get)

        // MARK: WHEN

        let authenticationResult: AuthenticationResult = try await connectionManager.doRequest(
            validStatusCodes: [400, 404],
            useAuthentication: false,
            request: request
        )

        // MARK: THEN

        XCTAssertEqual(expectedAuthenticationResult, authenticationResult)
    }

    func testAuthentication() async throws {
        let expectedAuthenticationResult = AuthenticationResult.makeStub()

        stub(
            condition: { urlRequest in
                let cookie = urlRequest.headers["Cookie"]
                XCTAssertEqual(cookie, "JSESSIONID=;SERVERID=")
                return true
            },
            response: { _ in
                HTTPStubsResponse(
                    data: try! JSONEncoder().encode(expectedAuthenticationResult),
                    statusCode: 200,
                    headers: ["Set-Cookie": "JSESSIONID=\(self.fakeToken);SERVERID=\(self.fakeServerId)"]
                )
            }
        )

        try stubResponse(
            condition: isHost(Self.host) && isPath(fakePath),
            response: JSONEncoder().encode(expectedAuthenticationResult),
            code: 200
        )

        _ = try await connectionManager.doRequest(
            validStatusCodes: [200],
            useAuthentication: true,
            request: URLRequest(
                url: URL(string: "https://\(Self.host)")!,
                method: .post
            )
        ) as AuthenticationResult

        HTTPStubs.removeAllStubs()

        stub(
            condition: { urlRequest in
                let cookie = urlRequest.headers["Cookie"]
                XCTAssertEqual(cookie, "JSESSIONID=\(self.fakeToken);SERVERID=\(self.fakeServerId)")
                return true
            },
            response: { _ in
                HTTPStubsResponse(
                    data: try! JSONEncoder().encode(expectedAuthenticationResult),
                    statusCode: 200,
                    headers: [:]
                )
            }
        )

        try stubResponse(
            condition: isHost(Self.host) && isPath(fakePath),
            response: JSONEncoder().encode(expectedAuthenticationResult),
            code: 200
        )

        _ = try await connectionManager.doRequest(
            validStatusCodes: [200],
            useAuthentication: true,
            request: URLRequest(
                url: URL(string: "https://\(Self.host)")!,
                method: .post
            )
        ) as AuthenticationResult
    }
}
