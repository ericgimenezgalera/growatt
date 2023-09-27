//
//  LoginNavigationViewModel.swift
//  UIFramework
//
//  Created by Eric Gimènez Galera on 14/9/23.
//  Copyright © 2023 eric.gimenez.galera. All rights reserved.
//

import Combine
import Foundation
import SwiftUI

public enum LoginRoute: String, Hashable {
    case onLogged
}

public protocol LoginNavigationViewModel {
    func navigate(route: LoginRoute)
    func cleanStackAndNavigate(route: LoginRoute)
    func pop()
    init()
}

public class LoginNavigationViewModelImpl: NavigationViewModel<LoginRoute>, LoginNavigationViewModel {}
