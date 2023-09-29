//
//  NavigationViewModelMock.swift
//  UIFramework
//
//  Created by Eric Gimènez Galera on 14/9/23.
//  Copyright © 2023 eric.gimenez.galera. All rights reserved.
//

import Foundation
@testable import UserInterface
import XCTest

class NavigationViewModelMock: NavigationViewModel {
    var navigateExpectation: XCTestExpectation?
    var navigateRoute: (any Hashable)?

    var popExpectation: XCTestExpectation?

    required init() {}

    @MainActor public override func navigate(route: any Hashable) async {
        navigateRoute = route
        navigateExpectation?.fulfill()
    }

    @MainActor public override func cleanStackAndNavigate(route: any Hashable) async {
        await navigate(route: route)
    }

    @MainActor public override func pop() async {
        popExpectation?.fulfill()
    }
}
