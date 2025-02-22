//
//  PasswordField.swift
//  Growatt
//
//  Created by Eric Gimenez on 15/2/25.
//  Copyright © 2025 eric.gimenez.galera. All rights reserved.
//

import DependencyInjection
import SwiftUI

public struct PasswordField: View {
    class ViewState: ObservableObject {
        @Published var password: String = ""
        @Published var showPassword: Bool = false

        let passwordVisibilityViewState: AsyncButtonViewState
        let passwordTextFieldId: String
        let passwordSecureFieldId: String
        let eyeButtonId: String
        weak var output: Output?

        init(
            passwordVisibilityViewState: AsyncButtonViewState,
            passwordTextFieldId: String = "passwordTextFieldId",
            passwordSecureFieldId: String = "passwordSecureFieldId",
            eyeButtonId: String = "eyeButtonId"
        ) {
            self.passwordVisibilityViewState = passwordVisibilityViewState
            self.passwordTextFieldId = passwordTextFieldId
            self.passwordSecureFieldId = passwordSecureFieldId
            self.eyeButtonId = eyeButtonId
        }
    }

    protocol Output: AnyObject {
        func didTapShowHidePassword() async
    }

    @ObservedObject var viewState: ViewState

    public var body: some View {
        HStack {
            Group {
                if viewState.showPassword {
                    TextField(
                        "Password",
                        text: $viewState.password,
                        prompt: Text("Password")
                    )
                    .id(viewState.passwordTextFieldId)
                } else {
                    SecureField(
                        "Password",
                        text: $viewState.password,
                        prompt: Text("Password")
                    )
                    .id(viewState.passwordSecureFieldId)
                }
            }
            .padding(10)
            .overlay {
                RoundedRectangle(cornerRadius: 10)
                    .stroke(.gray, lineWidth: 1)
            }

            AsyncButton(
                viewState: viewState.passwordVisibilityViewState,
                label: {
                    Image(systemName: viewState.showPassword ? "eye.slash" : "eye")
                        .tint(.black)
                }
            )
            .id(viewState.eyeButtonId)
        }
    }
}

#Preview {
    let viewState = PasswordField.ViewState(
        passwordVisibilityViewState: .init()
    )
//    viewState.showPassword = true

    return PasswordField(viewState: viewState)
}
