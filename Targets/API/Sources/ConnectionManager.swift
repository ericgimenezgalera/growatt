//
//  ConnectionManager.swift
//  API
//
//  Created by Eric Gimenez on 13/06/2022.
//

import Alamofire
import DependencyInjection
import Foundation
import KeychainWrapper

public enum ConnectionManagerError: Error, Equatable {
    case internalError(_ error: Error)
    case invalidStatusCode(expectedStatusCodes: [Int], receivedStatusCode: Int?)
    case parsingError

    public static func == (lhs: ConnectionManagerError, rhs: ConnectionManagerError) -> Bool {
        switch (lhs, rhs) {
        case (.internalError, .internalError):
            return true
        case (
            let .invalidStatusCode(lhsExpectedStatusCodes, lhsReceivedStatusCode),
            let .invalidStatusCode(rhsExpectedStatusCodes, rhsReceivedStatusCode)
        ):
            return lhsExpectedStatusCodes == rhsExpectedStatusCodes && lhsReceivedStatusCode == rhsReceivedStatusCode
        case (.parsingError, .parsingError):
            return true
        default:
            return false
        }
    }
}

public final class ConnectionManager: Sendable {
    typealias HTTPResponseHeaders = [String: String]

    public static let shared: ConnectionManager = .init()
    let baseURL: URL
    private var internalSessionManager: Session?
    var sessionManager: Session {
        guard let internalSessionManager = internalSessionManager else {
            AF.sessionConfiguration.waitsForConnectivity = true
            AF.sessionConfiguration.requestCachePolicy = .reloadIgnoringLocalCacheData
            internalSessionManager = AF
            return AF
        }
        return internalSessionManager
    }

    private let retryPolicy: RetryHandler = { _, _, _, completion in
        // TODO: implement retry policy
        completion(.doNotRetry)
    }

    public convenience init() {
        self.init(baseURL: URL(string: "https://server.growatt.com/")!)
    }

    public init(baseURL: URL) {
        self.baseURL = baseURL
    }

    func doRequest<T: Decodable>(
        validStatusCodes: [Int],
        request: URLRequest
    ) async throws -> T {
        let task = sessionManager
            .request(request, interceptor: Retrier(retryPolicy))
            .serializingDecodable(T.self)

        let response = await task.response

        if let error = response.error {
            throw ConnectionManagerError.internalError(error)
        }

        guard let statusCode = response.response?.statusCode, validStatusCodes.contains(statusCode) else {
            throw ConnectionManagerError.invalidStatusCode(
                expectedStatusCodes: validStatusCodes,
                receivedStatusCode: response.response?.statusCode
            )
        }

        return try await task.value
    }

    func debugDoRequest(
        validStatusCodes: [Int],
        request: URLRequest
    ) async throws -> String {
        let task = AF
            .request(request, interceptor: Retrier(retryPolicy))
            .serializingString()

        let response = await task.response

        if let error = response.error {
            throw ConnectionManagerError.internalError(error)
        }

        let response2 = String(data: response.data!, encoding: .utf8)!
        print(response2)

        guard let statusCode = response.response?.statusCode, validStatusCodes.contains(statusCode) else {
            throw ConnectionManagerError.invalidStatusCode(
                expectedStatusCodes: validStatusCodes,
                receivedStatusCode: response.response?.statusCode
            )
        }
        throw ConnectionManagerError.parsingError
    }
}
