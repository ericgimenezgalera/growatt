//
//  DILogoutUseCase.swift
//  UIFramework
//
//  Created by Eric Gimènez Galera on 14/9/23.
//  Copyright © 2023 eric.gimenez.galera. All rights reserved.
//

import DependencyInjection
import Foundation

private struct LogoutUseCaseKey: InjectionKey {
    static var currentValue: LogoutUseCase = LogoutUseCaseImpl()
}

extension InjectedValues {
    var logoutUseCase: LogoutUseCase {
        get { Self[LogoutUseCaseKey.self] }
        set { Self[LogoutUseCaseKey.self] = newValue }
    }
}
