//
//  DISessionManager.swift
//  UIFramework
//
//  Created by Eric Gimènez Galera on 14/9/23.
//  Copyright © 2023 eric.gimenez.galera. All rights reserved.
//

import DependencyInjection
import Foundation

private struct SessionManagerKey: @preconcurrency InjectionKey {
    @MainActor static var currentValue: SessionManager = ConnectionManager.shared
}

public extension InjectedValues {
    var sessionManager: SessionManager {
        get { Self[SessionManagerKey.self] }
        set { Self[SessionManagerKey.self] = newValue }
    }
}
