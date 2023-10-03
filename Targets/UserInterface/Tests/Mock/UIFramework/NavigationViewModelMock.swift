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

    required init() {}

    func navigate(route: any Hashable) async {
        navigateRoute = route
        navigateExpectation?.fulfill()
    }
}
