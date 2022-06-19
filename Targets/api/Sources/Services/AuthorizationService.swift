//
//  AuthorizationService.swift
//  api
//
//  Created by Eric Gimenez on 14/6/22.
//  Copyright © 2022 eric.gimenez.galera. All rights reserved.
//

import Foundation

public protocol AuthorizationService {
    func authorise(authentication: Authentication) async throws -> AuthenticationResult
}

extension ConnectionManager: AuthorizationService {
    public func authorise(authentication: Authentication) async throws -> AuthenticationResult {
        // 401 if not authenticate
        let result: AuthenticationResult = try await ConnectionManager.Builder(self)
            .addUrlSubPath(path: "newTwoLoginAPI.do")
            .httpMethod(.post)
            .encodeParameterInURL(parameter: authentication, includeBody: false)
            .validStatusCode(200)
            .doRequest()

        guard result.back.success else {
            throw ConnectionManagerError.invalidStatusCode(expectedStatusCodes: [200], receivedStatusCode: 401)
        }

        return result
    }
}
