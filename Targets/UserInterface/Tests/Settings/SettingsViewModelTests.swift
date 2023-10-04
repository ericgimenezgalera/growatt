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

    func testLogout() {
        let navigateExpectation = expectation(description: "Navigation success")
        navigationViewModelMock.navigateExpectation = navigateExpectation

        settingsViewModel.logout(navigationViewModel: navigationViewModelMock)

        wait(for: [navigateExpectation])
        XCTAssertEqual(
            navigationViewModelMock.navigateRoute as? SettingsNavigationRoute,
            SettingsNavigationRoute.onLogout
        )
    }

    func testGetPlantDataSuccess() async {
        settingsViewModel.getPlantData()

        switch await settingsViewModel.tasks.first?.result {
        case .success:
            XCTAssertEqual(settingsViewModel.plantDetails, settingsModelMock.getPlantDataResult)
        default:
            XCTFail("Not success task")
        }
    }

    func testGetPlantDataFailed() async {
        settingsModelMock.getPlantDataResult = nil

        settingsViewModel.getPlantData()
        switch await settingsViewModel.tasks.first?.result {
        case .success:
            XCTAssertNil(settingsViewModel.plantDetails)
        default:
            XCTFail("Not success task")
        }
    }

    func testGetPlantNotReloadInformationWhenCalledAgain() async {
        let expectedPlantDetails = settingsModelMock.getPlantDataResult
        settingsViewModel.getPlantData()

        switch await settingsViewModel.tasks.first?.result {
        case .success:
            XCTAssertEqual(settingsViewModel.plantDetails, expectedPlantDetails)
        default:
            XCTFail("Not success task")
        }

        settingsModelMock.getPlantDataResult = nil
        settingsViewModel.getPlantData()

        switch await settingsViewModel.tasks.first?.result {
        case .success:
            XCTAssertEqual(settingsViewModel.plantDetails, expectedPlantDetails)
        default:
            XCTFail("Not success task")
        }
    }
}
