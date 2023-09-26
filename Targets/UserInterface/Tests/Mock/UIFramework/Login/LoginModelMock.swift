//
//  LoginModelMock.swift
//  UIFramework
//
//  Created by Eric Gimènez Galera on 14/9/23.
//  Copyright © 2023 eric.gimenez.galera. All rights reserved.
//

import Foundation
@testable import UserInterface

class LoginModelMock: LoginModel {
    var loginResult = true

    func login(username _: String, password _: String) async -> Bool {
        loginResult
    }
}
