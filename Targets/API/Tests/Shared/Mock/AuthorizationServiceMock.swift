//
//  AuthorizationServiceMock.swift
//  UIFramework
//
//  Created by Eric Gimènez Galera on 14/9/23.
//  Copyright © 2023 eric.gimenez.galera. All rights reserved.
//

import API
import Foundation

public class AuthorizationServiceMock: AuthorizationService {
    public var success: Bool = true
    public var authentication: AuthenticationRequest?

    public func authorise(authentication: AuthenticationRequest) async throws {
        self.authentication = authentication
        guard success else {
            throw ConnectionManagerError.invalidStatusCode(expectedStatusCodes: [200], receivedStatusCode: 401)
        }
    }
}
