import API
import DependencyInjection
import Foundation
@testable import UserInterface
import XCTest

final class GetPlantDetailsUseCaseTests: XCTestCase {
    let username = "fakeUsername"
    var getPlantDetailsUseCase: GetPlantDetailsUseCaseImpl!
    var plantServiceMock: PlantServiceMock!
    let fakePlantDetails = PlantDetails.makeStub()

    override func setUp() {
        getPlantDetailsUseCase = .init()
        plantServiceMock = .init()
        InjectedValues[\.plantService] = plantServiceMock
    }

    func testGetPlantDetailsSuccess() async {
        plantServiceMock.plantListPlantDetailsReturnValue = fakePlantDetails

        let plantDetails = await getPlantDetailsUseCase.getPlantData()

        XCTAssertTrue(plantServiceMock.plantListPlantDetailsCalled)
        XCTAssertEqual(plantDetails, fakePlantDetails)
    }
    
    func testGetPlantDetailsFailed() async {
        plantServiceMock.plantListPlantDetailsThrowableError = NSError(domain: "Fake domain", code: -1)

        let plantDetails = await getPlantDetailsUseCase.getPlantData()

        XCTAssertTrue(plantServiceMock.plantListPlantDetailsCalled)
        XCTAssertNil(plantDetails)
    }
}
