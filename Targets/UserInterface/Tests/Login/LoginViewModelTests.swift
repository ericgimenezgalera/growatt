import Combine
import DependencyInjection
import Foundation
@testable import UserInterface
import XCTest

final class LoginViewModelTests: BaseViewModelTest<LoginViewModel> {
    let username = "fakeUsername"
    let password = "fakePassword"
    var loginModelMock: LoginModelMock!
    var navigationViewModelMock: NavigationViewModelMock!

    override func setUp() {
        viewModel = LoginViewModel()
        loginModelMock = LoginModelMock()
        navigationViewModelMock = NavigationViewModelMock()
        InjectedValues[\.loginModel] = loginModelMock
    }

    func testLoginSuccess() {
        loginModelMock.loginResult = true
        let navigateExpectation = expectation(description: "Navigation success")
        navigationViewModelMock.navigateExpectation = navigateExpectation

        waitForFinishedTask { viewModel in
            viewModel.isLoading = true
            viewModel.login(
                username: self.username,
                password: self.password,
                navigationViewModel: self.navigationViewModelMock
            )
        }

        wait(for: [navigateExpectation])
        XCTAssertEqual(navigationViewModelMock.navigateRoute as? LoginNavigationRoute, LoginNavigationRoute.onLogged)
        XCTAssertFalse(viewModel.isLoading)
    }

    @MainActor func testLoginDenied() {
        loginModelMock.loginResult = false

        waitForFinishedTask { viewModel in
            viewModel.isLoading = true
            viewModel.login(
                username: self.username,
                password: self.password,
                navigationViewModel: self.navigationViewModelMock
            )
        }
        switch viewModel.error {
        case .invalidPassword:
            break
        default:
            XCTFail("Invalid error type")
        }

        XCTAssertFalse(viewModel.isLoading)
    }

    func testLoginWithBiometricSuccess() {
        loginModelMock.loginWithBiometric = true
        let navigateExpectation = expectation(description: "Navigation success")
        navigationViewModelMock.navigateExpectation = navigateExpectation

        waitForFinishedTask { viewModel in
            viewModel.isLoading = true
            viewModel.loginWithBiometric(
                username: self.username,
                navigationViewModel: self.navigationViewModelMock
            )
        }

        wait(for: [navigateExpectation])
        XCTAssertEqual(navigationViewModelMock.navigateRoute as? LoginNavigationRoute, LoginNavigationRoute.onLogged)
        XCTAssertFalse(viewModel.isLoading)
    }

    func testLoginWithBiometricDenied() {
        loginModelMock.loginWithBiometric = false
        let navigateExpectation = expectation(description: "Navigation called")
        navigateExpectation.isInverted = true
        navigationViewModelMock.navigateExpectation = navigateExpectation

        waitForFinishedTask { viewModel in
            viewModel.isLoading = true
            viewModel.loginWithBiometric(
                username: self.username,
                navigationViewModel: self.navigationViewModelMock
            )
        }

        wait(for: [navigateExpectation], timeout: 0.1)
        XCTAssertFalse(viewModel.isLoading)
    }
}
