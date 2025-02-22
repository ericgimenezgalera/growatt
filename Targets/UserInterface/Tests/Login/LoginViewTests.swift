//
//  LoginViewTests.swift
//  UserInterfaceTests
//
//  Created by Eric Gimènez Galera on 13/10/23.
//  Copyright © 2023 eric.gimenez.galera. All rights reserved.
//
import Foundation
import SnapshotTesting
import SwiftUI
@testable import UserInterface
import XCTest

final class LoginViewTests: XCTestCase {
    let fakeUsername = "FakeUsername"
    let fakePassword = "FakePassword"
    var view: LoginView!
    var viewState: LoginView.ViewState!

    override func setUp() {
        viewState = .init(
            username: "",
            loginViewState: .init(),
            passwordViewState: .init(passwordVisibilityViewState: .init())
        )

        view = .init(viewState: viewState)
    }

    func testFreshInstallInitialState() {
        assertNamedSnapshot(matching: view, size: .init(width: 300, height: 500))
    }

    func testWithUsernameState() {
        viewState.username = fakeUsername
        assertNamedSnapshot(matching: view, size: .init(width: 300, height: 500))
    }

    func testWithHidePassword() {
        viewState.passwordViewState.password = fakePassword
        assertNamedSnapshot(matching: view, size: .init(width: 300, height: 500))
    }

    func testWithShowedPassword() {
        viewState.passwordViewState.password = fakePassword
        viewState.passwordViewState.showPassword = true
        assertNamedSnapshot(matching: view, size: .init(width: 300, height: 500))
    }

    func testWithUsernameAndPassword() {
        viewState.username = fakeUsername
        viewState.passwordViewState.password = fakePassword
        assertNamedSnapshot(matching: view, size: .init(width: 300, height: 500))
    }

    func testWithLoadingByPasswordVisibility() {
        viewState.username = fakeUsername
        viewState.passwordViewState.password = fakePassword
        viewState.passwordViewState.passwordVisibilityViewState.showProgressView = true

        assertNamedSnapshot(matching: view, size: .init(width: 300, height: 500))
    }

    func testWithLoadingByLoginTapped() {
        viewState.username = fakeUsername
        viewState.passwordViewState.password = fakePassword
        viewState.loginViewState.showProgressView = true

        assertNamedSnapshot(matching: view, size: .init(width: 300, height: 500))
    }
}
