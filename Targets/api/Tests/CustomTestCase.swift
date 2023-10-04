//
//  BaseTests.swift
//  APITests
//
//  Created by Eric Gimenez on 15/6/22.
//  Copyright © 2022 eric.gimenez.galera. All rights reserved.
//
@testable import API
import Foundation
import Mocker
import XCTest

class BaseTests: XCTestCase {
    static let host = "fake.host.com"
    static let baseUrl = URL(string: "https://\(host)")!

    var connectionManager: ConnectionManagerStub!

    override func setUp() {
        connectionManager = .init(baseURL: BaseTests.baseUrl)
    }

    func addPlantIdCookie() {
        let cookie = HTTPCookie(properties: [
            .domain: "aaa.bbbb.ccc",
            .path: "/",
            .name: "onePlantId",
            .value: "123456789",
            .version: 1,
            .secure: true,
            .expires: NSDate(timeIntervalSinceNow: 12345),
            .init(rawValue: "HttpOnly"): true,
        ])!
        HTTPCookieStorage.shared.setCookie(cookie)
    }

    func cleanAllCookies() {
        guard let cookies = HTTPCookieStorage.shared.cookies else {
            return
        }

        for cookie in cookies {
            HTTPCookieStorage.shared.deleteCookie(cookie)
        }
    }

    func stubResponse(
        subpath: String,
        ignoreQuery: Bool = true,
        cacheStoragePolicy: URLCache.StoragePolicy = .notAllowed,
        dataType: Mock.DataType = .json,
        statusCode: Int,
        data: [Mock.HTTPMethod: Data],
        additionalHeaders: [String: String] = [:],
        requestError: Error? = nil
    ) {
        let url = URL(string: "\(Self.baseUrl)/\(subpath)")!
        let mock = Mock(
            url: url,
            ignoreQuery: ignoreQuery,
            cacheStoragePolicy: cacheStoragePolicy,
            dataType: dataType,
            statusCode: statusCode,
            data: data,
            additionalHeaders: additionalHeaders,
            requestError: requestError
        )
        mock.register()
    }

    func assertThrowsAsyncError<T>(
        _ expression: @autoclosure () async throws -> T,
        _ message: @autoclosure () -> String = "",
        file: StaticString = #filePath,
        line: UInt = #line,
        _ errorHandler: (_ error: Error) -> Void = { _ in }
    ) async {
        do {
            _ = try await expression()
            // expected error to be thrown, but it was not
            let customMessage = message()
            if customMessage.isEmpty {
                XCTFail("Asynchronous call did not throw an error.", file: file, line: line)
            } else {
                XCTFail(customMessage, file: file, line: line)
            }
        } catch {
            errorHandler(error)
        }
    }
}
