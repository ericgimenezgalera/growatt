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
import KeychainWrapper
import LocalAuthentication

protocol LoginModel {
    func login(username: String, password: String) async -> Bool
    func loginWithBiometric(username: String) async -> Bool
}

class LoginModelImpl: LoginModel {
    @Injected(\.authorizationService) var authorizationService: AuthorizationService
    @Injected(\.keychainWrapper) var keychainWrapper: KeychainWrapper
    var context = LAContext()

    func login(username: String, password: String) async -> Bool {
        let authentication = AuthenticationRequest(account: username, password: password)
        do {
            try await authorizationService.authorise(authentication: authentication)
            return true
        } catch {
            return false
        }
    }

    func loginWithBiometric(username: String) async -> Bool {
        guard !username.isEmpty,
              let password: String = try? keychainWrapper.get(account: passwordKeychainAccount) else {
            return false
        }

        context.localizedCancelTitle = "Enter Username/Password"
        guard context.canEvaluatePolicy(.deviceOwnerAuthentication, error: nil) else {
            return false
        }

        guard (try? await context.evaluatePolicy(
            .deviceOwnerAuthentication,
            localizedReason: "Log in to your account"
        )) ?? false else {
            return false
        }

        return await login(username: username, password: password)
    }
}
