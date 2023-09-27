//
//  LoginModel.swift
//  UIFramework
//
//  Created by Eric Gimènez Galera on 13/9/23.
//  Copyright © 2023 eric.gimenez.galera. All rights reserved.
//

import API
import DependencyInjection
import Foundation

protocol LoginModel {
    func login(username: String, password: String) async -> Bool
}

class LoginModelImpl: LoginModel {
    @Injected(\.authorizationService) var authorizationService: AuthorizationService

    func login(username: String, password: String) async -> Bool {
        let authentication = Authentication(account: username, password: password)
        do {
            try await authorizationService.authorise(authentication: authentication)
            return true
        } catch {
            return false
        }
    }
}
