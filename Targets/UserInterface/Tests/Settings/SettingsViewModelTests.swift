import Combine
import DependencyInjection
import Foundation
@testable import UserInterface
import XCTest

final class SettingsViewModelTests: BaseViewModelTest<SettingsViewModel> {
    var settingsModelMock: SettingsModelMock!
    var navigationViewModelMock: NavigationViewModelMock!

    override func setUp() {
        viewModel = SettingsViewModel()
        settingsModelMock = SettingsModelMock()
        navigationViewModelMock = NavigationViewModelMock()
        InjectedValues[\.settingsModel] = settingsModelMock
    }

    func testLogout() {
        let navigateExpectation = expectation(description: "Navigation success")
        navigationViewModelMock.navigateExpectation = navigateExpectation

        waitForFinishedTask { viewModel in
            viewModel.logout(navigationViewModel: self.navigationViewModelMock)
        }

        wait(for: [navigateExpectation])
        XCTAssertEqual(
            navigationViewModelMock.navigateRoute as? SettingsNavigationRoute,
            SettingsNavigationRoute.onLogout
        )
    }

    func testGetPlantDataSuccess() async {
        waitForFinishedTask { $0.getPlantData() }

        XCTAssertEqual(viewModel.plantDetails, settingsModelMock.getPlantDataResult)
    }

    func testGetPlantDataFailed() async {
        settingsModelMock.getPlantDataResult = nil

        waitForFinishedTask { $0.getPlantData() }

        XCTAssertNil(viewModel.plantDetails)
    }

    func testGetPlantNotReloadInformationWhenCalledAgain() async {
        let expectedPlantDetails = settingsModelMock.getPlantDataResult

        waitForFinishedTask { $0.getPlantData() }

        XCTAssertEqual(viewModel.plantDetails, expectedPlantDetails)

        settingsModelMock.getPlantDataResult = nil

        waitForFinishedTask { $0.getPlantData() }

        XCTAssertEqual(viewModel.plantDetails, expectedPlantDetails)
    }
}
