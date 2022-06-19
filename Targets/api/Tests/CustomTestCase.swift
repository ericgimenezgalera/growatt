//
//  BaseTests.swift
//  APITests
//
//  Created by Eric Gimenez on 15/6/22.
//  Copyright © 2022 eric.gimenez.galera. All rights reserved.
//
@testable import API
import Foundation
import OHHTTPStubs
import XCTest

class BaseTests: XCTestCase {
    static let host = "fake.host.com"
    static let baseUrl = URL(string: "https://\(host)")!

    var connectionManager: ConnectionManager!

    override func setUp() {
        HTTPStubs.removeAllStubs()
        connectionManager = .init(baseURL: BaseTests.baseUrl)
    }

    func stubResponse(
        condition: @escaping HTTPStubsTestBlock = isHost(host),
        response: Data,
        code: Int32
    ) {
        stub(
            condition: condition
        ) { _ -> HTTPStubsResponse in
            HTTPStubsResponse(data: response, statusCode: code, headers: .none)
        }
    }
}
