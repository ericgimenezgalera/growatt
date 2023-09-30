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

    @MainActor override public func navigate(route: any Hashable) async {
        navigateRoute = route
        navigateExpectation?.fulfill()
    }

    @MainActor override public func cleanStackAndNavigate(route: any Hashable) async {
        await navigate(route: route)
    }

    @MainActor override public func pop() async {
        popExpectation?.fulfill()
    }
}
