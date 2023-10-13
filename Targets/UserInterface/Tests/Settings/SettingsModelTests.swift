import DependencyInjection
import Foundation
@testable import UserInterface
import XCTest

final class SettingsModelTests: XCTestCase {
    var model: SettingsModelImpl!
    var sessionManagerMock: SessionManagerMock!
    var plantServiceMock: PlantServiceMock!

    override func setUp() {
        model = SettingsModelImpl()
        sessionManagerMock = SessionManagerMock()
        plantServiceMock = PlantServiceMock()
        InjectedValues[\.sessionManager] = sessionManagerMock
        InjectedValues[\.plantService] = plantServiceMock
    }

    func testLogout() {
        let logoutExpectation = expectation(description: "Logout success")
        sessionManagerMock.logoutExpectation = logoutExpectation
        model.logout()

        wait(for: [logoutExpectation])
    }

    func testGetPlantDetailsSuccess() async {
        let plantDetails = await model.getPlantData()
        XCTAssertEqual(plantDetails, plantServiceMock.plantDetailsResult)
    }

    func testGetPlantDetailsFailed() async {
        plantServiceMock.plantListSuccess = false

        let plantDetails = await model.getPlantData()
        XCTAssertNil(plantDetails)
    }
}
