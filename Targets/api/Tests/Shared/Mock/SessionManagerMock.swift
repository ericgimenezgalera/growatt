//
//  SessionManagerMock.swift
//  UIFramework
//
//  Created by Eric Gimènez Galera on 14/9/23.
//  Copyright © 2023 eric.gimenez.galera. All rights reserved.
//

import API
import Foundation
import XCTest

public class SessionManagerMock: SessionManager {
    var logoutExpectation: XCTestExpectation?

    public func logout() {
        logoutExpectation?.fulfill()
    }
}
