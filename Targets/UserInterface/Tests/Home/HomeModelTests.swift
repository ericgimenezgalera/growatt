import DependencyInjection
import Foundation
@testable import UserInterface
import XCTest

final class HomeModelTests: XCTestCase {
    var model: HomeModelImpl!
    var productionServiceMock: ProductServiceMock!
    var plantServiceMock: PlantServiceMock!

    override func setUp() {
        model = HomeModelImpl()
        productionServiceMock = ProductServiceMock()
        plantServiceMock = PlantServiceMock()
        InjectedValues[\.productionService] = productionServiceMock
        InjectedValues[\.plantService] = plantServiceMock
    }

    func testLoadSocialContributionSuccess() async {
        let socialContribution = await model.loadSocialContribution()
        XCTAssertEqual(socialContribution, plantServiceMock.socialContributionResult)
    }

    func testLoadSocialContributionFailed() async {
        plantServiceMock.socialContributionSuccess = false

        let socialContribution = await model.loadSocialContribution()
        XCTAssertNil(socialContribution)
    }

    func testLoadCurrentProductionSuccess() async {
        let currentProduction = await model.loadCurrentProduction()
        XCTAssertEqual(currentProduction, productionServiceMock.currentProductionResult)
    }

    func testoadCurrentProductionFailed() async {
        productionServiceMock.currentProductionSuccess = false

        let currentProduction = await model.loadCurrentProduction()
        XCTAssertNil(currentProduction)
    }

    func testLoadDailyProductionSuccess() async {
        let dailyProduction = await model.loadDailyProduction()
        XCTAssertEqual(dailyProduction, productionServiceMock.dailyProductionResult)
    }

    func testLoadDailyProductionFailed() async {
        productionServiceMock.dailyProductionSuccess = false

        let dailyProduction = await model.loadDailyProduction()
        XCTAssertNil(dailyProduction)
    }
}
