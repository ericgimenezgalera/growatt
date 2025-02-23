//
//  HomeViewTests.swift
//  UserInterfaceTests
//
//  Created by Eric Gimènez Galera on 13/10/23.
//  Copyright © 2023 eric.gimenez.galera. All rights reserved.
//

import API
import DependencyInjection
import Foundation
import SwiftUI
@testable import UserInterface
import ViewInspector
import XCTest

final class HomeViewTests: XCTestCase {
    var view: HomeView!
    var viewState: HomeView.ViewState!

    override func setUp() {
        viewState = .init()
        view = .init(viewState: viewState)
    }

    @MainActor
    func testInitialState() async {
        assertNamedSnapshot(matching: view, size: .init(width: 350, height: 400))
    }

    @MainActor
    func testInitialStateWithLoadedData() async {
        viewState.currentProduction = Production(totalSolar: 1, exportToGrid: 2, importFromGrid: 3, useInLocal: 5)
        viewState.socialContribution = SocialContribution(co2: 9999, tree: 12345, coal: 54321)

        await viewState.homeEnergyProgressBarViewState.progressView.updateData(
            section: HomeEnergyStorage.selfConsumed.rawValue,
            to: 0.3
        )
        await viewState.homeEnergyProgressBarViewState.progressView.updateData(
            section: HomeEnergyStorage.importedFromGrid.rawValue,
            to: 0.7
        )

        await viewState.solarProductionProgressBarViewState.progressView.updateData(
            section: HomeEnergyStorage.selfConsumed.rawValue,
            to: 0.6
        )
        await viewState.solarProductionProgressBarViewState.progressView.updateData(
            section: HomeEnergyStorage.importedFromGrid.rawValue,
            to: 0.4
        )

        viewState.isLoading = false
        assertNamedSnapshot(matching: view, size: .init(width: 350, height: 700))
    }
}
