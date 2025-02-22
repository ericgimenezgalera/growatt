import DependencyInjection
import Foundation
@testable import UserInterface
import XCTest
import API

final class HomeModelTests: XCTestCase {
    var model: HomeModelImpl!
    var productionServiceMock: ProductServiceMock!
    var plantServiceMock: PlantServiceMock!
    let mockSocialcontribution = SocialContribution.makeStub()
    let fakePlantDetails = PlantDetails.makeStub()

    override func setUp() {
        model = HomeModelImpl()
        productionServiceMock = ProductServiceMock()
        plantServiceMock = PlantServiceMock()
        InjectedValues[\.productionService] = productionServiceMock
        InjectedValues[\.plantService] = plantServiceMock
    }

    func testLoadSocialContributionSuccess() async {
        plantServiceMock.socialContributionSocialContributionReturnValue = mockSocialcontribution

        let socialContribution = await model.loadSocialContribution()
        XCTAssertEqual(socialContribution, mockSocialcontribution)
    }

    func testLoadSocialContributionFailed() async {
        plantServiceMock.socialContributionSocialContributionThrowableError = NSError(domain: "Fake domian", code: -1)

        let socialContribution = await model.loadSocialContribution()
        XCTAssertNil(socialContribution)
    }

    func testLoadCurrentProductionSuccess() async {
        plantServiceMock.plantListPlantDetailsReturnValue = fakePlantDetails

        let currentProduction = await model.loadCurrentProduction()
        XCTAssertEqual(currentProduction, productionServiceMock.currentProductionResult)
    }

    func testoadCurrentProductionFailed() async {
        plantServiceMock.plantListPlantDetailsReturnValue = fakePlantDetails
        productionServiceMock.currentProductionSuccess = false

        let currentProduction = await model.loadCurrentProduction()
        XCTAssertNil(currentProduction)
    }

    func testLoadDailyProductionSuccess() async {
        plantServiceMock.plantListPlantDetailsReturnValue = fakePlantDetails

        let dailyProduction = await model.loadDailyProduction()
        XCTAssertEqual(dailyProduction, productionServiceMock.dailyProductionResult)
    }

    func testLoadDailyProductionFailed() async {
        plantServiceMock.plantListPlantDetailsReturnValue = fakePlantDetails
        productionServiceMock.dailyProductionSuccess = false

        let dailyProduction = await model.loadDailyProduction()
        XCTAssertNil(dailyProduction)
    }
}
