import Combine
import DependencyInjection
import Foundation
@testable import UserInterface
import XCTest

final class HomeViewModelTests: XCTestCase {
    var homeViewModel: HomeViewModel!
    var homeModelMock: HomeModelMock!
    var homeEnergyProgressViewMock: SwiftUiMultiProgressViewMock!
    var solarProductionProgressViewMock: SwiftUiMultiProgressViewMock!

    override func setUp() {
        homeViewModel = HomeViewModel()
        homeModelMock = HomeModelMock()
        homeEnergyProgressViewMock = .init()
        solarProductionProgressViewMock = .init()
        InjectedValues[\.homeModel] = homeModelMock
    }

    func testLoadProductionData() async {
        homeViewModel.loadProductionData(
            homeEnergyProgressVar: homeEnergyProgressViewMock,
            solarProductionProgressVar: solarProductionProgressViewMock
        )

        switch await homeViewModel.tasks.first?.result {
        case .success:
            XCTAssertEqual(homeViewModel.currentProduction, homeModelMock.loadCurrentProductionResult)
            XCTAssertEqual(homeViewModel.socialContribution, homeModelMock.loadSocialContributionResult)
            let dailyProductionMock = homeModelMock.loadDailyProductionResult
            let homeEnergyCalls = homeEnergyProgressViewMock.updatedDataCalls
            XCTAssertEqual(homeEnergyCalls.count, 2)
            XCTAssertEqual(homeEnergyCalls[0].0, 0)
            XCTAssertEqual(
                homeEnergyCalls[0].1,
                Float(dailyProductionMock.selfConsumed / dailyProductionMock.totalLocal)
            )
            XCTAssertEqual(homeEnergyCalls[1].0, 1)
            XCTAssertEqual(
                homeEnergyCalls[1].1,
                Float(dailyProductionMock.importedFromGrid / dailyProductionMock.totalLocal)
            )

            let solarProductionCalls = solarProductionProgressViewMock.updatedDataCalls
            XCTAssertEqual(solarProductionCalls.count, 2)
            XCTAssertEqual(solarProductionCalls[0].0, 0)
            XCTAssertEqual(
                solarProductionCalls[0].1,
                Float(dailyProductionMock.selfConsumed / dailyProductionMock.totalSolar)
            )
            XCTAssertEqual(solarProductionCalls[1].0, 1)
            XCTAssertEqual(
                solarProductionCalls[1].1,
                Float(dailyProductionMock.exportedToGrid / dailyProductionMock.totalSolar)
            )
        default:
            XCTFail("Not success task")
        }
    }
}
