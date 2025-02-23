//
//  LoginPage.swift
//  Growatt
//
//  Created by Eric Gimenez on 23/2/25.
//  Copyright © 2025 eric.gimenez.galera. All rights reserved.
//
@testable import UserInterface
import XCTest

class LoginPage: BasePage {
    private let passwordTextFieldId = Element(id: LoginConstants.passwordTextFieldId, type: .textField)
    private let passwordSecureFieldId = Element(id: LoginConstants.passwordSecureFieldId, type: .secureTextField)
    private let eyeButton = Element(id: LoginConstants.eyeButtonId, type: .button)
    private let signInButton = Element(id: LoginConstants.signinButtonId, type: .button)

    private var securedPassword: Bool = true

    init() {
        super.init(rootElement: Element(id: LoginConstants.usernameTextFieldId, type: .textField))
    }

    func writeUsername(_ username: String) -> LoginPage {
        rootElement.typeText(text: username)
        return self
    }

    func writePassword(_ password: String) -> LoginPage {
        let element = selectPasswordElement()
        element.waitForElement()

        element.typeText(text: password)
        return self
    }

    func tapOnEyeButton() -> LoginPage {
        eyeButton.waitForElement()

        eyeButton.tap()
        securedPassword.toggle()
        return self
    }

    func signIn() -> HomePage {
        signInButton.waitForElement()

        signInButton.tap()
        return .init()
    }

    private func selectPasswordElement() -> Element {
        if securedPassword {
            passwordSecureFieldId
        } else {
            passwordTextFieldId
        }
    }
}
