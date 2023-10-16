//
//  LoginViewTests.swift
//  UserInterfaceTests
//
//  Created by Eric Gimènez Galera on 13/10/23.
//  Copyright © 2023 eric.gimenez.galera. All rights reserved.
//

import DependencyInjection
import Foundation
import SwiftUI
@testable import UserInterface
import ViewInspector
import XCTest

final class LoginViewTests: BaseViewTest<LoginView> {
    let fakeUsername = "FakeUsername"
    let fakePassword = "FakePassword"

    var navigationViewModel: NavigationViewModelMock!
    var loginViewModelMock: LoginViewModelMock!

    override func setUp() {
        navigationViewModel = NavigationViewModelMock()
        loginViewModelMock = LoginViewModelMock()
        view = LoginView(navigationViewModel, viewModel: loginViewModelMock)
        UserDefaults.standard.removeObject(forKey: usernameUserDefaultsKey)
    }

    func testFreshInstallInitialState() throws {
        onAppearView { view in
            XCTAssertTrue(self.loginViewModelMock.loginWithBiometricCalled)
            XCTAssertEqual(self.loginViewModelMock.loginWithBiometricParameters?.0, "")
            XCTAssertTrue(self.loginViewModelMock.isLoading)
            XCTAssertFalse(try view.find(viewWithId: spinnerViewId).isHidden())
        }
    }

    func testWithUsernameInitialState() throws {
        UserDefaults.standard.setValue(fakeUsername, forKey: usernameUserDefaultsKey)

        onAppearView { view in
            XCTAssertTrue(self.loginViewModelMock.loginWithBiometricCalled)
            XCTAssertEqual(self.loginViewModelMock.loginWithBiometricParameters?.0, self.fakeUsername)
            XCTAssertTrue(self.loginViewModelMock.isLoading)
            XCTAssertFalse(try view.find(viewWithId: spinnerViewId).isHidden())
        }
    }

    func testEyeButton() throws {
        onAppearView { view in
            self.loginViewModelMock.isLoading = false

            _ = try view.find(viewWithId: passwordSecureFieldId)
            XCTAssertThrowsError(try view.find(viewWithId: passwordTextFieldId))

            try view.find(viewWithId: eyeButtonId).button().tap()

            _ = try view.find(viewWithId: passwordTextFieldId)
            XCTAssertThrowsError(try view.find(viewWithId: passwordSecureFieldId))

            try view.find(viewWithId: eyeButtonId).button().tap()

            _ = try view.find(viewWithId: passwordSecureFieldId)
            XCTAssertThrowsError(try view.find(viewWithId: passwordTextFieldId))
        }
    }

    func testLoginWithUserNameAndPassword() throws {
        onAppearView { view in
            self.loginViewModelMock.isLoading = false

            XCTAssertThrowsError(try view.find(viewWithId: signinButtonId).button().tap())
            try view.find(viewWithId: usernameTextFieldId).textField().setInput(self.fakeUsername)
            XCTAssertThrowsError(try view.find(viewWithId: signinButtonId).button().tap())
            try view.find(viewWithId: passwordSecureFieldId).secureField().setInput(self.fakePassword)
            XCTAssertFalse(self.loginViewModelMock.loginCalled)

            try view.find(viewWithId: signinButtonId).button().tap()

            XCTAssertTrue(self.loginViewModelMock.loginCalled)
            XCTAssertEqual(self.loginViewModelMock.loginParameters?.0, self.fakeUsername)
            XCTAssertEqual(self.loginViewModelMock.loginParameters?.1, self.fakePassword)
        }
    }

    func testSpinner() throws {
        onAppearView { view in
            XCTAssertTrue(self.loginViewModelMock.isLoading)
            _ = try view.find(viewWithId: spinnerViewId)

            self.loginViewModelMock.isLoading = false
            XCTAssertThrowsError(try view.find(viewWithId: spinnerViewId))

            self.loginViewModelMock.isLoading = true
            _ = try view.find(viewWithId: spinnerViewId)
        }
    }
}
