//
//  DILoginModel.swift
//  UIFramework
//
//  Created by Eric Gimènez Galera on 14/9/23.
//  Copyright © 2023 eric.gimenez.galera. All rights reserved.
//

import DependencyInjection
import Foundation

private struct LoginModelKey: InjectionKey {
    static var currentValue: LoginModel = LoginModelImpl()
}

extension InjectedValues {
    var loginModel: LoginModel {
        get { Self[LoginModelKey.self] }
        set { Self[LoginModelKey.self] = newValue }
    }
}
