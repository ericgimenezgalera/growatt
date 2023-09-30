import Combine
import DependencyInjection
import Foundation
@testable import UserInterface
import XCTest

final class SettingsViewModelTests: XCTestCase {
    var settingsViewModel: SettingsViewModel!
    var settingsModelMock: SettingsModelMock!
    var navigationViewModelMock: NavigationViewModelMock!

    override func setUp() {
        settingsViewModel = SettingsViewModel()
        settingsModelMock = SettingsModelMock()
        navigationViewModelMock = NavigationViewModelMock()
        InjectedValues[\.settingsModel] = settingsModelMock
    }

    func test_logout() {
        let navigateExpectation = expectation(description: "Navigation success")
        navigationViewModelMock.navigateExpectation = navigateExpectation

        settingsViewModel.logout(navigationViewModel: navigationViewModelMock)

        wait(for: [navigateExpectation])
        XCTAssertEqual(
            navigationViewModelMock.navigateRoute as? SettingsNavigationRoute,
            SettingsNavigationRoute.onLogout
        )
    }
}
