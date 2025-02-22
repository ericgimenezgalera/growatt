//
//  LogoutUseCase.swift
//  UIFramework
//
//  Created by Eric Gimènez Galera on 13/9/23.
//  Copyright © 2023 eric.gimenez.galera. All rights reserved.
//

import API
import DependencyInjection
import Foundation

// sourcery: AutoMockable
protocol LogoutUseCase {
    func logout()
}

class LogoutUseCaseImpl: LogoutUseCase {
    @Injected(\.sessionManager) var sessionManager: SessionManager

    func logout() {
        sessionManager.logout()
    }
}
