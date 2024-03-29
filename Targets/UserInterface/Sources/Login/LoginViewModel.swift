//
//  LoginViewModel.swift
//  UIFramework
//
//  Created by Eric Gimènez Galera on 13/9/23.
//  Copyright © 2023 eric.gimenez.galera. All rights reserved.
//

import DependencyInjection
import Foundation

enum LoginViewModelError: LocalizedError {
    case invalidPassword

    var errorDescription: String? {
        switch self {
        case .invalidPassword:
            return "Invalid password, please try again"
        }
    }

    var recoverySuggestion: String? {
        switch self {
        case .invalidPassword:
            return "Login failed with this user and password, please change it and try again"
        }
    }
}

class LoginViewModel: ViewModel {
    @Injected(\.loginModel) private var loginModel: LoginModel
    @MainActor @Published var error: LoginViewModelError?
    @Published var isLoading: Bool = false

    func login(username: String, password: String, navigationViewModel: NavigationViewModel) {
        let task = Task.detached(priority: .background) { [weak self] in
            defer {
                DispatchQueue.main.sync { [weak self] in
                    self?.isLoading = false
                }
            }
            guard let loginModel = self?.loginModel else {
                return
            }

            guard await loginModel.login(username: username, password: password) else {
                await self?.showInvalidPassword()
                return
            }

            await navigationViewModel.navigate(route: LoginNavigationRoute.onLogged)
        }
        tasks.append(task)
    }

    func loginWithBiometric(username: String, navigationViewModel: NavigationViewModel) {
        let task = Task.detached(priority: .background) { [weak self] in
            defer {
                DispatchQueue.main.sync { [weak self] in
                    self?.isLoading = false
                }
            }
            guard let loginModel = self?.loginModel else {
                return
            }

            guard await loginModel.loginWithBiometric(username: username)
            else {
                return
            }

            await navigationViewModel.navigate(route: LoginNavigationRoute.onLogged)
        }
        tasks.append(task)
    }

    @MainActor func showInvalidPassword() {
        error = LoginViewModelError.invalidPassword
    }
}
