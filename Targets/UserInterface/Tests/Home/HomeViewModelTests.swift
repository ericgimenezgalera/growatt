import API
import Combine
import DependencyInjection
import Foundation
@testable import UserInterface
import XCTest

final class HomeViewModelTests: XCTestCase {
    var productionUseCaseMock: ProductionUseCaseMock!
    var viewModel: HomeViewModel!
    let anyCurrentProduction = Production.makeStub()
    let anySocialContribution = SocialContribution.makeStub()
    let anyDailyProduction = DailyProduction.makeStub()

    @MainActor override func setUp() {
        viewModel = HomeViewModel()
        productionUseCaseMock = .init()
        InjectedValues[\.productionUseCase] = productionUseCaseMock
    }

    func testLoadProductionData() async {
        productionUseCaseMock.loadCurrentProductionProductionReturnValue = anyCurrentProduction
        productionUseCaseMock.loadDailyProductionDailyProductionReturnValue = anyDailyProduction
        productionUseCaseMock.loadSocialContributionSocialContributionReturnValue = anySocialContribution

        await viewModel.loadData()

        XCTAssertEqual(viewModel.viewState.currentProduction, anyCurrentProduction)
        XCTAssertEqual(viewModel.viewState.socialContribution, anySocialContribution)

        let currentSefConsumedPercentage = await viewModel.viewState.homeEnergyProgressBarViewState.progressView
            .progress(forSection: HomeEnergyStorage.selfConsumed.rawValue)
        let currentImportedFromGridPercentage = await viewModel.viewState.homeEnergyProgressBarViewState.progressView
            .progress(forSection: HomeEnergyStorage.importedFromGrid.rawValue)

        XCTAssertEqual(
            currentSefConsumedPercentage,
            Float(anyDailyProduction.selfConsumed / anyDailyProduction.totalLocal)
        )
        XCTAssertEqual(
            currentImportedFromGridPercentage,
            Float(anyDailyProduction.importedFromGrid / anyDailyProduction.totalLocal)
        )

        let currentSefConsumedForsolarPercentage = await viewModel.viewState.solarProductionProgressBarViewState
            .progressView.progress(forSection: SolarProductionStorage.selfConsumed.rawValue)
        let currentExportedToGridPercentage = await viewModel.viewState.solarProductionProgressBarViewState.progressView
            .progress(forSection: SolarProductionStorage.exportedToGrid.rawValue)

        XCTAssertEqual(
            currentSefConsumedForsolarPercentage,
            Float(anyDailyProduction.selfConsumed / anyDailyProduction.totalSolar)
        )
        XCTAssertEqual(
            currentExportedToGridPercentage,
            Float(anyDailyProduction.exportedToGrid / anyDailyProduction.totalSolar)
        )
    }
}
