//
//  ConnectionManager.swift
//  API
//
//  Created by Eric Gimenez on 13/06/2022.
//

import Alamofire
import Foundation

public enum ConnectionManagerError: Error, Equatable {
    case internalError
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

public class ConnectionManager {
    typealias HTTPResponseHeaders = [String: String]

    let baseURL: URL
    private(set) var jSessionId: String = ""
    private(set) var serverId: String = ""
    private var internalSessionManager: Session?
    var sessionManager: Session {
        guard let internalSessionManager = internalSessionManager else {
            AF.sessionConfiguration.waitsForConnectivity = true
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
        self.init(baseURL: URL(string: "https://server-api.growatt.com")!)
    }

    public init(baseURL: URL) {
        self.baseURL = baseURL
    }

    func doRequest<T: Decodable>(
        validStatusCodes: [Int],
        useAuthentication: Bool,
        request: URLRequest
    ) async throws -> T {
        var request = request

        if useAuthentication {
            request.headers.add(name: "Cookie", value: "JSESSIONID=\(jSessionId);SERVERID=\(serverId)")
        }

        let task = sessionManager
            .request(request, interceptor: Retrier(retryPolicy))
            .serializingDecodable(T.self)

        let response = await task.response

        if response.error != nil {
            throw ConnectionManagerError.internalError
        }

        updateStoredCredentials(response.response?.headers)

        guard let statusCode = response.response?.statusCode, validStatusCodes.contains(statusCode) else {
            throw ConnectionManagerError.invalidStatusCode(
                expectedStatusCodes: validStatusCodes,
                receivedStatusCode: response.response?.statusCode
            )
        }
        return try await task.value
    }

    private func updateStoredCredentials(_ headers: HTTPHeaders?) {
        if let line = headers?["Set-Cookie"] {
            let headerLines = line.split(separator: ";")
            for line in headerLines {
                let keyValue = line.split(separator: "=", maxSplits: 1)
                if let key = keyValue.first, let value = keyValue.last, key.contains("JSESSIONID") {
                    jSessionId = String(value)
                } else if let key = keyValue.first, let value = keyValue.last, key.contains("SERVERID") {
                    serverId = String(value)
                }
            }
        }
    }

    func debugDoRequest(
        validStatusCodes: [Int],
        useAuthentication: Bool,
        request: URLRequest
    ) async throws -> String {
        var request = request
        if useAuthentication {
            request.headers.add(name: "Cookie", value: "JSESSIONID=\(jSessionId);SERVERID=\(serverId)")
        }

        let task = AF
            .request(request, interceptor: Retrier(retryPolicy))
            .serializingString()

        let response = await task.response

        if let error = response.error {
            throw ConnectionManagerError.internalError
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
