//
//  AuthorizationServiceMock.swift
//  UIFramework
//
//  Created by Eric Gimènez Galera on 14/9/23.
//  Copyright © 2023 eric.gimenez.galera. All rights reserved.
//

import API
import Foundation

class AuthorizationServiceMock: AuthorizationService {
    var success: Bool = true

    func authorise(authentication _: API.Authentication) async throws {
        guard success else {
            throw ConnectionManagerError.invalidStatusCode(expectedStatusCodes: [200], receivedStatusCode: 401)
        }
    }
}
