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

public class NavigationViewModelMock: NavigationViewModel {
    public var navigateExpectation: XCTestExpectation?
    public var navigateRoute: (any Hashable)?

    public required init() {}

    public func navigate(route: any Hashable) async {
        navigateRoute = route
        navigateExpectation?.fulfill()
    }
}
