//
//  LoginNavigationViewModelMock.swift
//  UIFramework
//
//  Created by Eric Gimènez Galera on 14/9/23.
//  Copyright © 2023 eric.gimenez.galera. All rights reserved.
//

import Foundation
@testable import UserInterface
import XCTest

class LoginNavigationViewModelMock: LoginNavigationViewModel {
    var navigateExpectation: XCTestExpectation?
    var navigateRoute: LoginRoute?

    var popExpectation: XCTestExpectation?

    required init() {}

    func navigate(route: LoginRoute) {
        navigateRoute = route

        navigateExpectation?.fulfill()
    }

    func cleanStackAndNavigate(route: UserInterface.LoginRoute) {
        navigate(route: route)
    }

    func pop() {
        popExpectation?.fulfill()
    }
}
