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
    case invalidStatusCode(expectedStatusCodes:[Int], receivedStatusCode: Int?)
    case parsingError
    
    public static func == (lhs: ConnectionManagerError, rhs: ConnectionManagerError) -> Bool {
        switch (lhs, rhs) {
        case (.internalError, .internalError):
            return true
        case (let .invalidStatusCode(lhsExpectedStatusCodes, lhsReceivedStatusCode), let .invalidStatusCode(rhsExpectedStatusCodes, rhsReceivedStatusCode)):
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
    private var jSessionId: String = ""
    private let retryPolicy: RetryHandler = { request, session, error, completion in
        // TODO: implement retry policy
        completion(.doNotRetry)
    }
    
    
    public init(baseURL: URL) {
        self.baseURL = baseURL
        AF.sessionConfiguration.waitsForConnectivity = true
    }
    
    func doRequest<T: Decodable>(
        validStatusCodes: [Int],
        useAuthentication: Bool,
        request: URLRequest
    ) async throws -> T {
        var request = request
        
        if useAuthentication {
            request.headers.add(name: "Cookie", value: "JSESSIONID=\(jSessionId)")
        }
        
        let task = AF
            .request(request, interceptor: Retrier(retryPolicy))
            .serializingDecodable(T.self)

        let response = await task.response
        
        if response.error != nil {
            throw ConnectionManagerError.internalError
        }
        
        updateStoredCredentials(response.response?.headers)

        guard let statusCode = response.response?.statusCode, validStatusCodes.contains(statusCode) else {
            throw ConnectionManagerError.invalidStatusCode(expectedStatusCodes: validStatusCodes, receivedStatusCode: response.response?.statusCode)
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
            request.headers.add(name: "Cookie", value: "JSESSIONID=\(jSessionId)")
        }
        
        let task = AF
            .request(request, interceptor: Retrier(retryPolicy))
            .serializingString()

        let response = await task.response
        
        if response.error != nil {
            throw ConnectionManagerError.internalError
        }
        
        let response2: String = String(data: response.data!, encoding: .utf8)!
        print(response2)
        
        guard let statusCode = response.response?.statusCode, validStatusCodes.contains(statusCode) else {
            throw ConnectionManagerError.invalidStatusCode(expectedStatusCodes: validStatusCodes, receivedStatusCode: response.response?.statusCode)
        }
        throw ConnectionManagerError.parsingError
    }
}
