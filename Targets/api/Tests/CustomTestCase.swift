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
}
