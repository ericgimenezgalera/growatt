import API
import Combine
import DependencyInjection
import Foundation
@testable import UserInterface
import XCTest

final class SettingsViewModelTests: XCTestCase {
    var navigationViewModelMock: NavigationViewModelMock!
    var viewModel: SettingsViewModel!
    var logoutUsecaseMock: LogoutUseCaseMock!
    var getPlantDetailsUseCaseMock: GetPlantDetailsUseCaseMock!
    let fakePlantDetails = PlantDetails.makeStub()

    override func setUp() {
        navigationViewModelMock = NavigationViewModelMock()
        viewModel = SettingsViewModel(navigationViewModel: navigationViewModelMock)
        logoutUsecaseMock = .init()
        getPlantDetailsUseCaseMock = .init()
        InjectedValues[\.logoutUseCase] = logoutUsecaseMock
        InjectedValues[\.getPlantDetailsUseCase] = getPlantDetailsUseCaseMock
    }

    func testOnLogout() async {
        await viewModel.logout()

        XCTAssertTrue(logoutUsecaseMock.logoutVoidCalled)
        XCTAssertEqual(
            navigationViewModelMock.navigateRouteAnyHashableVoidReceivedRoute as? SettingsNavigationRoute,
            .onLogout
        )
    }

    func testGetPlantDataSuccess() async {
        getPlantDetailsUseCaseMock.getPlantDataPlantDetailsReturnValue = fakePlantDetails

        await viewModel.onAppear()

        XCTAssertTrue(getPlantDetailsUseCaseMock.getPlantDataPlantDetailsCalled)
        XCTAssertEqual(viewModel.viewState.plantDetails, fakePlantDetails)
    }

    func testGetPlantDataFailed() async {
        getPlantDetailsUseCaseMock.getPlantDataPlantDetailsReturnValue = nil

        await viewModel.onAppear()

        XCTAssertTrue(getPlantDetailsUseCaseMock.getPlantDataPlantDetailsCalled)
        XCTAssertNil(viewModel.viewState.plantDetails)
    }

    func testGetPlantNotReloadInformationWhenCalledAgain() async {
        getPlantDetailsUseCaseMock.getPlantDataPlantDetailsReturnValue = fakePlantDetails

        await viewModel.onAppear()

        XCTAssertTrue(getPlantDetailsUseCaseMock.getPlantDataPlantDetailsCalled)
        XCTAssertEqual(getPlantDetailsUseCaseMock.getPlantDataPlantDetailsCallsCount, 1)
        XCTAssertEqual(viewModel.viewState.plantDetails, fakePlantDetails)

        await viewModel.onAppear()

        XCTAssertTrue(getPlantDetailsUseCaseMock.getPlantDataPlantDetailsCalled)
        XCTAssertEqual(getPlantDetailsUseCaseMock.getPlantDataPlantDetailsCallsCount, 1)
        XCTAssertEqual(viewModel.viewState.plantDetails, fakePlantDetails)
    }
}
