//
//  AuthorizationServiceMock.swift
//  UIFramework
//
//  Created by Eric Gimènez Galera on 14/9/23.
//  Copyright © 2023 eric.gimenez.galera. All rights reserved.
//

import API
import Foundation
import XCTest

class SessionManagerMock: SessionManager {
    var logoutExpectation: XCTestExpectation?

    func logout() {
        logoutExpectation?.fulfill()
    }
}
