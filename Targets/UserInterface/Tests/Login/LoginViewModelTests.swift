import Combine
import DependencyInjection
import Foundation
@testable import UserInterface
import XCTest

final class LoginViewModelTests: XCTestCase {
    let username = "fakeUsername"
    let password = "fakePassword"
    var loginUseCaseMock: LoginUseCaseMock!
    var navigationViewModelMock: NavigationViewModelMock!
    var viewModel: LoginViewModel!

    override func setUp() {
        UserDefaults.standard.removeObject(forKey: usernameUserDefaultsKey)

        navigationViewModelMock = NavigationViewModelMock()
        viewModel = LoginViewModel(navigationViewModel: navigationViewModelMock)
        loginUseCaseMock = LoginUseCaseMock()
        InjectedValues[\.loginUseCase] = loginUseCaseMock
    }

    func testInitialState() async {
        XCTAssertEqual(viewModel.viewState.username, "")
        XCTAssertNotNil(viewModel.viewState.output)
        XCTAssertEqual(viewModel.viewState.passwordViewState.password, "")
        XCTAssertNotNil(viewModel.viewState.passwordViewState)
    }

    func testSetUsernameFromUserDefaults() async {
        UserDefaults.standard.set(username, forKey: usernameUserDefaultsKey)
        viewModel = LoginViewModel(navigationViewModel: navigationViewModelMock)

        XCTAssertEqual(viewModel.viewState.username, username)
    }

    func testLoginSuccess() async {
        loginUseCaseMock.loginUsernameStringPasswordStringBoolReturnValue = true

        viewModel.viewState.username = username
        viewModel.viewState.passwordViewState.password = password

        await viewModel.didTapLogin()

        XCTAssertEqual(navigationViewModelMock.navigateRouteAnyHashableVoidReceivedRoute as? LoginNavigationRoute, .onLogged)
        XCTAssertNil(viewModel.viewState.alertError)
        XCTAssertFalse(viewModel.viewState.showError)
    }

    func testLoginDenied() async {
        loginUseCaseMock.loginUsernameStringPasswordStringBoolReturnValue = false

        viewModel.viewState.username = username
        viewModel.viewState.passwordViewState.password = password

        await viewModel.didTapLogin()

        XCTAssertNil(navigationViewModelMock.navigateRouteAnyHashableVoidReceivedRoute)
        XCTAssertEqual(viewModel.viewState.alertError, .invalidPassword)
        XCTAssertTrue(viewModel.viewState.showError)
    }

    func testLoginWithBiometricSuccess() async {
        loginUseCaseMock.loginWithBiometricUsernameStringBoolReturnValue = true

        viewModel.viewState.username = username

        await viewModel.loginWithBiometric()

        XCTAssertEqual(navigationViewModelMock.navigateRouteAnyHashableVoidReceivedRoute as? LoginNavigationRoute, .onLogged)
        XCTAssertNil(viewModel.viewState.alertError)
        XCTAssertFalse(viewModel.viewState.showError)
    }

    func testLoginWithBiometricDenied() async {
        loginUseCaseMock.loginWithBiometricUsernameStringBoolReturnValue = false

        viewModel.viewState.username = username

        await viewModel.loginWithBiometric()

        XCTAssertNil(navigationViewModelMock.navigateRouteAnyHashableVoidReceivedRoute)
        XCTAssertNil(viewModel.viewState.alertError)
        XCTAssertFalse(viewModel.viewState.showError)
    }
}
