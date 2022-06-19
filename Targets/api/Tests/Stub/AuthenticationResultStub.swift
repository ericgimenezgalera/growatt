//
//  AuthenticationResultStub.swift
//  APITests
//
//  Created by Eric Gimenez on 15/6/22.
//  Copyright © 2022 eric.gimenez.galera. All rights reserved.
//

import Foundation
@testable import API

extension AuthenticationResult {
    static func makeStub() -> AuthenticationResult {
        AuthenticationResult(back: AuthenticationResultDetails.makeStub())
    }
    
    static func makeStub(authenticationResultDetails: AuthenticationResultDetails) -> AuthenticationResult {
        AuthenticationResult(back: authenticationResultDetails)
    }
}
