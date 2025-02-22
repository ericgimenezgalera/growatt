//
//  LoginViewModelMock.swift
//  UserInterfaceTests
//
//  Created by Eric Gimènez Galera on 16/10/23.
//  Copyright © 2023 eric.gimenez.galera. All rights reserved.
//

import Foundation
@testable import UserInterface

class LoginViewModelMock: LoginViewModel {
    var loginCalled: Bool = false

    var loginWithBiometricCalled: Bool = false

    override func didTapLogin() async {
        loginCalled = true
    }

    override func loginWithBiometric() async {
        loginWithBiometricCalled = true
    }
}
