//
//  ConnectionManagerBuiilder.swift
//  api
//
//  Created by Eric Gimenez on 14/6/22.
//  Copyright © 2022 eric.gimenez.galera. All rights reserved.
//

import Alamofire
import Foundation

extension ConnectionManager {
    class Builder {
        private var request: URLRequest
        private let encoder: JSONEncoder
        private let connectionManager: ConnectionManager
        private var validStatusCode = [200]
        private var useAuthentication = false
        private var traceId: String?

        init(
            _ connectionManager: ConnectionManager,
            _ encodingStrategy: JSONEncoder.KeyEncodingStrategy = .useDefaultKeys
        ) {
            request = URLRequest(url: connectionManager.baseURL)
            request.cachePolicy = .reloadIgnoringLocalCacheData
            encoder = JSONEncoder()
            encoder.keyEncodingStrategy = encodingStrategy
            self.connectionManager = connectionManager
        }

        func encodeParameterInHttpBody<T: Encodable>(parameter: T) throws -> Builder {
            request.headers.add(name: "Content-Type", value: "application/json")
            request.httpBody = try encoder.encode(parameter)
            return self
        }

        func encodeParameterInURL<T: Encodable>(parameter: T, includeBody: Bool = false) throws -> Builder {
            request.headers.add(name: "Content-Type", value: "application/x-www-form-urlencoded; charset=utf-8")
            if let jsonParameters = try JSONSerialization.jsonObject(
                with: try encoder.encode(parameter),
                options: .allowFragments
            ) as? [String: String] {
                var components = URLComponents(string: request.url!.absoluteString)!
                components.queryItems = jsonParameters.map { key, value in
                    URLQueryItem(name: key, value: value)
                }
                if includeBody {
                    let urlAllowed: CharacterSet =
                        .alphanumerics.union(.init(charactersIn: "-._~&=")) // RFC 3986 + &=
                    request.httpBody = components.query?
                        .addingPercentEncoding(withAllowedCharacters: urlAllowed)?
                        .data(using: .utf8)
                } else {
                    components.percentEncodedQuery = components.percentEncodedQuery?
                        .replacingOccurrences(of: "+", with: "%2B")
                    request.url = components.url
                }
            } else {
                throw ConnectionManagerError.parsingError
            }
            return self
        }

        func addAuthentication() -> Builder {
            useAuthentication = true
            return self
        }

        func addHeaders(headers: HTTPHeaders) -> Builder {
            headers.forEach { httpHeader in
                request.headers.add(httpHeader)
            }
            return self
        }

        func addUrlSubPath(path: String) -> Builder {
            request.url?.appendPathComponent(path)
            return self
        }

        func addHeader(name: String, value: String) -> Builder {
            request.headers.add(name: name, value: value)
            return self
        }

        func httpMethod(_ httpMethod: HTTPMethod) -> Builder {
            request.httpMethod = httpMethod.rawValue
            return self
        }

        func validStatusCode(_ statusCode: Int) -> Builder {
            validStatusCode = [statusCode]
            return self
        }

        func validStatusCodes(_ statusCodes: [Int]) -> Builder {
            validStatusCode = statusCodes
            return self
        }

        func doRequest<T: Codable>() async throws -> T {
            try await connectionManager.doRequest(
                validStatusCodes: validStatusCode,
                useAuthentication: useAuthentication,
                request: request
            )
        }

        func debugDoRequest() async throws -> String {
            try await connectionManager.debugDoRequest(
                validStatusCodes: validStatusCode,
                useAuthentication: useAuthentication,
                request: request
            )
        }
    }
}
