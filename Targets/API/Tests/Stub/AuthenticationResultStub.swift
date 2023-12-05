//
//  AuthenticationResultStub.swift
//  APITests
//
//  Created by Eric Gimenez on 15/6/22.
//  Copyright © 2022 eric.gimenez.galera. All rights reserved.
//

@testable import API
import Foundation

extension AuthenticationResult {
    static func makeStub() -> AuthenticationResult {
        AuthenticationResult(result: 1)
    }

    static func makeStub(_ result: Int) -> AuthenticationResult {
        AuthenticationResult(result: result)
    }
}
