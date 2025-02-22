//
//  LoginViewModel.swift
//  Growatt
//
//  Created by Eric Gimenez on 16/2/25.
//  Copyright © 2025 eric.gimenez.galera. All rights reserved.
//

import DependencyInjection
import Foundation
import SwiftUI

public class LoginViewModel: LoginView.Output {
    @Injected(\.loginUseCase) private var loginModel: LoginUseCase
    @AppStorage(usernameUserDefaultsKey) var username: String = ""

    public let viewState: LoginView.ViewState
    let passwordFieldViewModel: PasswordFieldViewModel
    let navigationViewModel: NavigationViewModel

    public init(navigationViewModel: NavigationViewModel) {
        self.navigationViewModel = navigationViewModel
        passwordFieldViewModel = .init(
            passwordTextFieldId: LoginConstants.passwordTextFieldId,
            passwordSecureFieldId: LoginConstants.passwordSecureFieldId,
            eyeButtonId: LoginConstants.eyeButtonId
        )

        viewState = .init(
            username: "",
            loginViewState: .init(buttonId: LoginConstants.signinButtonId),
            passwordViewState: passwordFieldViewModel.viewState
        )

        viewState.loginViewState.action = { [weak self] in
            await self?.didTapLogin()
        }
        viewState.username = username
        viewState.output = self
    }

    func didTapLogin() async {
        guard await loginModel.login(username: viewState.username, password: viewState.passwordViewState.password)
        else {
            await showInvalidPassword()
            return
        }

        await navigationViewModel.navigate(route: LoginNavigationRoute.onLogged)
    }

    func loginWithBiometric() async {
        guard await loginModel.loginWithBiometric(username: viewState.username) else {
            return
        }

        await navigationViewModel.navigate(route: LoginNavigationRoute.onLogged)
    }

    @MainActor
    private func showInvalidPassword() {
        viewState.alertError = LoginViewModelError.invalidPassword
        viewState.showError = true
    }
}
