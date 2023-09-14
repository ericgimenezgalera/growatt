//
//  LoginNavigationViewModelMock.swift
//  UIFramework
//
//  Created by Eric Gimènez Galera on 14/9/23.
//  Copyright © 2023 eric.gimenez.galera. All rights reserved.
//

import Foundation
@testable import UIFramework
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

    func pop() {
        popExpectation?.fulfill()
    }
}
