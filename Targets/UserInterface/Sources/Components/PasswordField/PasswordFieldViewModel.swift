//
//  PasswordFieldViewModel.swift
//  Growatt
//
//  Created by Eric Gimenez on 15/2/25.
//  Copyright © 2025 eric.gimenez.galera. All rights reserved.
//

class PasswordFieldViewModel {
    let viewState: PasswordField.ViewState

    init(
        passwordTextFieldId: String,
        passwordSecureFieldId: String,
        eyeButtonId: String
    ) {
        let passwordVisibilityViewState = AsyncButtonViewState()
        viewState = .init(
            passwordVisibilityViewState: passwordVisibilityViewState,
            passwordTextFieldId: passwordTextFieldId,
            passwordSecureFieldId: passwordSecureFieldId,
            eyeButtonId: eyeButtonId
        )
        passwordVisibilityViewState.action = { @MainActor [weak self] in
            self?.viewState.showPassword.toggle()
        }
    }
}
