import API
import DependencyInjection
import Foundation
@testable import UserInterface
import XCTest

final class ProductionUseCaseTests: XCTestCase {
    var productionUseCase: ProductionUseCaseImpl!
    var productionServiceMock: ProductionServiceMock!
    var plantServiceMock: PlantServiceMock!
    let anySocialcontribution = SocialContribution.makeStub()
    let anyPlantDetails = PlantDetails.makeStub()
    let anyProduction = Production.makeStub()
    let anyDailyProduction = DailyProduction.makeStub()

    override func setUp() {
        productionUseCase = .init()
        productionServiceMock = .init()
        plantServiceMock = .init()
        InjectedValues[\.productionService] = productionServiceMock
        InjectedValues[\.plantService] = plantServiceMock
    }

    func testLoadSocialContributionSuccess() async {
        plantServiceMock.socialContributionSocialContributionReturnValue = anySocialcontribution

        let socialContribution = await productionUseCase.loadSocialContribution()
        XCTAssertEqual(socialContribution, anySocialcontribution)
    }

    func testLoadSocialContributionFailed() async {
        plantServiceMock.socialContributionSocialContributionThrowableError = NSError(domain: "Fake domian", code: -1)

        let socialContribution = await productionUseCase.loadSocialContribution()
        XCTAssertNil(socialContribution)
    }

    func testLoadCurrentProductionSuccess() async {
        plantServiceMock.plantListPlantDetailsReturnValue = anyPlantDetails
        productionServiceMock.currentProductionDatalogSerialNumberStringProductionReturnValue = anyProduction

        let currentProduction = await productionUseCase.loadCurrentProduction()
        XCTAssertEqual(currentProduction, anyProduction)
    }

    func testoadCurrentProductionFailed() async {
        plantServiceMock.plantListPlantDetailsReturnValue = anyPlantDetails
        productionServiceMock.currentProductionDatalogSerialNumberStringProductionThrowableError = NSError(
            domain: "Fake domian",
            code: -1
        )

        let currentProduction = await productionUseCase.loadCurrentProduction()
        XCTAssertNil(currentProduction)
    }

    func testLoadDailyProductionSuccess() async {
        plantServiceMock.plantListPlantDetailsReturnValue = anyPlantDetails
        productionServiceMock
            .dailyProductionDatalogSerialNumberStringInverterSerialNumberStringDailyProductionReturnValue =
            anyDailyProduction

        let dailyProduction = await productionUseCase.loadDailyProduction()
        XCTAssertEqual(dailyProduction, anyDailyProduction)
    }

    func testLoadDailyProductionFailed() async {
        plantServiceMock.plantListPlantDetailsReturnValue = anyPlantDetails
        productionServiceMock
            .dailyProductionDatalogSerialNumberStringInverterSerialNumberStringDailyProductionThrowableError = NSError(
                domain: "Fake domian",
                code: -1
            )

        let dailyProduction = await productionUseCase.loadDailyProduction()
        XCTAssertNil(dailyProduction)
    }
}
