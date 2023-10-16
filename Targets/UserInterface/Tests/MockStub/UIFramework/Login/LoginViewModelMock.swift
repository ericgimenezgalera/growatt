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
    var loginParameters: (String, String, NavigationViewModel)?

    var loginWithBiometricCalled: Bool = false
    var loginWithBiometricParameters: (String, NavigationViewModel)?

    override func login(username: String, password: String, navigationViewModel: NavigationViewModel) {
        loginCalled = true
        loginParameters = (username, password, navigationViewModel)
    }

    override func loginWithBiometric(username: String, navigationViewModel: NavigationViewModel) {
        loginWithBiometricCalled = true
        loginWithBiometricParameters = (username, navigationViewModel)
    }
}
