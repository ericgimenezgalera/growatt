//
//  DILoginModel.swift
//  UIFramework
//
//  Created by Eric Gimènez Galera on 14/9/23.
//  Copyright © 2023 eric.gimenez.galera. All rights reserved.
//

import DependencyInjection
import Foundation

private struct LoginUseCaseKey: InjectionKey {
    static var currentValue: LoginUseCase = LoginUseCaseImpl()
}

extension InjectedValues {
    var loginUseCase: LoginUseCase {
        get { Self[LoginUseCaseKey.self] }
        set { Self[LoginUseCaseKey.self] = newValue }
    }
}
