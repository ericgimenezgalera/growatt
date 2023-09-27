//
//  NavigationViewModel.swift
//  UIFramework
//
//  Created by Eric Gimènez Galera on 14/9/23.
//  Copyright © 2023 eric.gimenez.galera. All rights reserved.
//

import Foundation
import SwiftUI

public class NavigationViewModel<T: Hashable>: ObservableObject {
    @MainActor @Published public var path = NavigationPath()

    public required init() {}

    @MainActor public func cleanStackAndNavigate(route: T) {
        path.removeLast(path.count)
        navigate(route: route)
    }

    @MainActor public func navigate(route: T) {
        path.append(route)
    }

    @MainActor public func pop() {
        path.removeLast()
    }
}
