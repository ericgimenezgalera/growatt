//
//  AuthorizationService.swift
//  api
//
//  Created by Eric Gimenez on 14/6/22.
//  Copyright © 2022 eric.gimenez.galera. All rights reserved.
//

import Foundation

public protocol AuthorizationService {
    func authorise(authentication: Authentication) async throws
}

extension ConnectionManager: AuthorizationService {
    public func authorise(authentication: Authentication) async throws {
        // 401 if not authenticate
        let result: AuthenticationResult = try await ConnectionManager.Builder(self)
            .addUrlSubPath(path: "login")
            .addAuthentication()
            .httpMethod(.post)
            .encodeParameterInURL(parameter: authentication, includeBody: false)
            .validStatusCode(200)
            .doRequest()

        guard result.result == 1 else {
            throw ConnectionManagerError.invalidStatusCode(expectedStatusCodes: [200], receivedStatusCode: 401)
        }
    }
}
