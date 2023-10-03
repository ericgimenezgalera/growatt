//
//  NavigationViewModel.swift
//  UIFramework
//
//  Created by Eric Gimènez Galera on 14/9/23.
//  Copyright © 2023 eric.gimenez.galera. All rights reserved.
//

import Foundation
import SwiftUI

public protocol NavigationViewModel {
    func navigate(route: any Hashable) async
}

class MockNavigationViewModel: NavigationViewModel {
    func navigate(route _: any Hashable) async {}
}
