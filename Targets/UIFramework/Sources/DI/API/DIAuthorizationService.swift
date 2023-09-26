//
//  DIAuthorizationService.swift
//  UIFramework
//
//  Created by Eric Gimènez Galera on 14/9/23.
//  Copyright © 2023 eric.gimenez.galera. All rights reserved.
//

import API
import DIFramework
import Foundation

private struct AuthorizationServiceKey: InjectionKey {
    static var currentValue: AuthorizationService = ConnectionManager()
}

extension InjectedValues {
    var authorizationService: AuthorizationService {
        get { Self[AuthorizationServiceKey.self] }
        set { Self[AuthorizationServiceKey.self] = newValue }
    }
}
