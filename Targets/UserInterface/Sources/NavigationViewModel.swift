//
//  NavigationViewModel.swift
//  UIFramework
//
//  Created by Eric Gimènez Galera on 14/9/23.
//  Copyright © 2023 eric.gimenez.galera. All rights reserved.
//

import Foundation
import SwiftUI

public class NavigationViewModel: ObservableObject {
    @MainActor @Published public var path = NavigationPath()

    public required init() {}

    @MainActor public func cleanStackAndNavigate(route: any Hashable) async {
        await MainActor.run {
            path.removeLast(path.count)
            path.append(route)
            path.removeLast()
        }
    }

    @MainActor public func navigate(route: any Hashable) async {
        await MainActor.run {
            path.append(route)
        }
    }

    @MainActor public func pop() async {
        await MainActor.run {
            path.removeLast()
        }
    }
}
