import Combine
import DIFramework
import Foundation
@testable import UIFramework
import XCTest

final class LoginViewModelTests: XCTestCase {
    let username = "fakeUsername"
    let password = "fakePassword"
    var loginViewModel: LoginViewModel!
    var loginModelMock: LoginModelMock!
    var loginNavigationViewModelMock: LoginNavigationViewModelMock!

    override func setUp() {
        loginViewModel = LoginViewModel()
        loginModelMock = LoginModelMock()
        loginNavigationViewModelMock = LoginNavigationViewModelMock()
        InjectedValues[\.loginModel] = loginModelMock
    }

    func test_success() {
        loginModelMock.loginResult = true
        let navigateExpectation = expectation(description: "Navigation success")
        loginNavigationViewModelMock.navigateExpectation = navigateExpectation

        loginViewModel.login(
            username: username,
            password: password,
            loginNavigationViewModel: loginNavigationViewModelMock
        )

        wait(for: [navigateExpectation])
        XCTAssertEqual(loginNavigationViewModelMock.navigateRoute, .onLogged)
    }

    func test_denied() {
        loginModelMock.loginResult = false

        let errorExpectation = expectation(description: "Navigation Error")
        let completaionExpectation = expectation(description: "Completion task")

        Task {
            loginViewModel.login(
                username: username,
                password: password,
                loginNavigationViewModel: loginNavigationViewModelMock
            )

            switch await loginViewModel.tasks.first?.result {
            case .success:
                _ = await loginViewModel.error.publisher.sink { _ in
                    completaionExpectation.fulfill()
                } receiveValue: { error in
                    if case LoginViewModelError.invalidPassword = error {
                        errorExpectation.fulfill()
                    }
                }
            default:
                break
            }
        }

        wait(for: [errorExpectation, completaionExpectation], timeout: 100.0)
    }
}
