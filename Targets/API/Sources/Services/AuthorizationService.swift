//
//  AuthorizationService.swift
//  api
//
//  Created by Eric Gimenez on 14/6/22.
//  Copyright © 2022 eric.gimenez.galera. All rights reserved.
//

import Foundation

public protocol AuthorizationService {
    func authorise(authentication: AuthenticationRequest) async throws
}

extension ConnectionManager: AuthorizationService {
    public func authorise(authentication: AuthenticationRequest) async throws {
        // 401 if not authenticate
        let authenticationResult = try await ConnectionManager.Builder(self)
            .addUrlSubPath(path: "login")
            .httpMethod(.post)
            .encodeParameterInURL(parameter: authentication, includeBody: false)
            .validStatusCode(200)
            .doRequest() as AuthenticationResult

        guard authenticationResult.result == 1 else {
            throw ConnectionManagerError.invalidStatusCode(expectedStatusCodes: [200], receivedStatusCode: 401)
        }
    }
}
