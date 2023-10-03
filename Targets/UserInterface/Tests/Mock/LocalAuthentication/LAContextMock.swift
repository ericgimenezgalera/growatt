//
//  LAContextMock.swift
//  KeychainWrapperTests
//
//  Created by Eric Gimènez Galera on 3/10/23.
//  Copyright © 2023 eric.gimenez.galera. All rights reserved.
//

import Foundation
import LocalAuthentication

enum LAContextMockError: Error {
    case generic
}

class LAContextMock: LAContext {
    var canEvaluatePolicyResult = true
    var evaluatePolicy = true
    var evaluateThowError = false

    override func canEvaluatePolicy(_: LAPolicy, error _: NSErrorPointer) -> Bool {
        canEvaluatePolicyResult
    }

    override func evaluatePolicy(_: LAPolicy, localizedReason _: String) async throws -> Bool {
        guard !evaluateThowError else {
            throw LAContextMockError.generic
        }
        return evaluatePolicy
    }
}
