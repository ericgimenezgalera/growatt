//
//  LoginView.swift
//  Growatt
//
//  Created by Eric Gimenez on 16/2/25.
//  Copyright © 2025 eric.gimenez.galera. All rights reserved.
//

import DependencyInjection
import SwiftUI

public struct LoginView: View {
    public class ViewState: ObservableObject {
        @Published var username: String
        @Published var showError: Bool = false
        @Published var alertError: LoginViewModelError?
        let loginViewState: AsyncButtonViewState
        let passwordViewState: PasswordField.ViewState
        var output: Output?

        init(
            username: String,
            loginViewState: AsyncButtonViewState,
            passwordViewState: PasswordField.ViewState
        ) {
            self.username = username
            self.loginViewState = loginViewState
            self.passwordViewState = passwordViewState
        }
    }

    protocol Output: AnyObject {
        func loginWithBiometric() async
    }

    @ObservedObject var viewState: ViewState
    @ObservedObject var passwordViewState: PasswordField.ViewState
    @ObservedObject var loginViewState: AsyncButtonViewState

    public init(viewState: ViewState) {
        self.viewState = viewState
        passwordViewState = viewState.passwordViewState
        loginViewState = viewState.loginViewState
    }

    var showLoading: Bool {
        viewState.loginViewState.showProgressView || passwordViewState.passwordVisibilityViewState.showProgressView
    }

    var disabledLoginButton: Bool {
        viewState.username.isEmpty || passwordViewState.password.isEmpty
    }

    public var body: some View {
        VStack(alignment: .leading, spacing: 15) {
            Spacer()

            TextField(
                "Name",
                text: $viewState.username,
                prompt: Text("Login")
                    .foregroundColor(.gray)
            )
            .id(LoginConstants.usernameTextFieldId)
            .padding(10)
            .overlay {
                RoundedRectangle(cornerRadius: 10)
                    .stroke(.gray, lineWidth: 1)
            }
            .padding(.horizontal)

            PasswordField(viewState: viewState.passwordViewState)
                .padding(.horizontal)

            Spacer()

            AsyncButton(viewState: viewState.loginViewState, label: {
                Text("Sign In")
                    .font(.title2)
                    .bold()
                    .foregroundColor(.white)
            })
            .id(LoginConstants.signinButtonId)
            .frame(height: 50)
            .frame(maxWidth: .infinity) // how to make a button fill all the space available horizontaly
            .background(
                disabledLoginButton ? LinearGradient(
                    colors: [.gray],
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                ) :
                    LinearGradient(colors: [.blue, .red], startPoint: .topLeading, endPoint: .bottomTrailing)
            )
            .cornerRadius(20)
            .disabled(disabledLoginButton)
            .padding()
        }
        .alert(
            isPresented: $viewState.showError,
            error: viewState.alertError,
            actions: {}
        )
        .disabled(
            showLoading
        )
        .overlay(Group {
            if showLoading {
                ZStack {
                    Color(white: 0, opacity: 0.75)
                    ProgressView().tint(.white)
                }
                .ignoresSafeArea()
                .id(LoginConstants.spinnerViewId)
            }
        })
        .onAppear {
            await viewState.output?.loginWithBiometric()
        }
    }
}

#Preview {
    let viewState = LoginView.ViewState(
        username: "Test user",
        loginViewState: .init(),
        passwordViewState: .init(
            passwordVisibilityViewState: .init()
        )
    )

//    viewState.loginViewState.showProgressView = true
//    viewState.passwordViewState.passwordVisibilityViewState.showProgressView = true
//    viewState.passwordViewState.showPassword = true

    return LoginView(viewState: viewState)
}
