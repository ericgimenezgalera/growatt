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

final class HomeViewTests: BaseViewTest<HomeView> {
    var homeViewModelMock: HomeViewModelMock!

    override func setUp() {
        homeViewModelMock = HomeViewModelMock()
        view = HomeView(viewModel: homeViewModelMock)
    }

    func testInitialState() throws {
        onAppearView { view in
            XCTAssertTrue(self.homeViewModelMock.isLoading)
            XCTAssertTrue(self.homeViewModelMock.loadProductionDataCalled)
            XCTAssertFalse(try view.find(viewWithId: HomeConstants.spinnerId).isHidden())
        }
    }

    func testSpinner() throws {
        onAppearView { view in
            XCTAssertTrue(self.homeViewModelMock.isLoading)
            _ = try view.find(viewWithId: HomeConstants.spinnerId)

            self.homeViewModelMock.isLoading = false
            XCTAssertThrowsError(try view.find(viewWithId: HomeConstants.spinnerId))

            self.homeViewModelMock.isLoading = true
            _ = try view.find(viewWithId: HomeConstants.spinnerId)
        }
    }

    func testCurrentProduction() throws {
        let production = Production.makeStub()
        homeViewModelMock.currentProduction = production
        onAppearView { view in
            let totalSolar = try view.find(viewWithId: HomeConstants.totalSolarId)
                .labeledContent().text(0).string()
            let useInLocal = try view.find(viewWithId: HomeConstants.useInLocalId)
                .labeledContent().text(0).string()
            let exportToGrid = try view.find(viewWithId: HomeConstants.exportToGridId)
                .labeledContent().text(0).string()
            let importFromGrid = try view.find(viewWithId: HomeConstants.importFromGridId)
                .labeledContent().text(0).string()

            XCTAssertEqual(totalSolar, "\(production.totalSolar) W")
            XCTAssertEqual(useInLocal, "\(production.useInLocal) W")
            XCTAssertEqual(exportToGrid, "\(production.exportToGrid) W")
            XCTAssertEqual(importFromGrid, "\(production.importFromGrid) W")
        }
    }

    func testSocialContribution() throws {
        let socialContribution = SocialContribution.makeStub()
        homeViewModelMock.socialContribution = socialContribution
        onAppearView { view in
            let tree = try view.find(viewWithId: HomeConstants.treeId)
                .text().string()
            let co2 = try view.find(viewWithId: HomeConstants.co2Id)
                .text().string()

            XCTAssertEqual(tree, "\(socialContribution.tree)")
            XCTAssertEqual(co2, "\(Int(socialContribution.co2))")
        }
    }

    // Missing test we can't call refresh at this moment with ViewInspector 0.9.9 they need to implement it.
    /* func testRefreshData() {
         let production = Production.makeStub()
         homeViewModelMock.currentProduction = production
         onAppearView { view in
             let totalSolar = try view.find(viewWithId: HomeConstants.totalSolarId)
                 .labeledContent().text(0).string()
             let useInLocal = try view.find(viewWithId: HomeConstants.useInLocalId)
                 .labeledContent().text(0).string()
             let exportToGrid = try view.find(viewWithId: HomeConstants.exportToGridId)
                 .labeledContent().text(0).string()
             let importFromGrid = try view.find(viewWithId: HomeConstants.importFromGridId)
                 .labeledContent().text(0).string()

             XCTAssertEqual(totalSolar, "\(production.totalSolar) W")
             XCTAssertEqual(useInLocal, "\(production.useInLocal) W")
             XCTAssertEqual(exportToGrid, "\(production.exportToGrid) W")
             XCTAssertEqual(importFromGrid, "\(production.importFromGrid) W")

             let production = Production(totalSolar: 10.0, exportToGrid: 5.0, importFromGrid: 7.0, useInLocal: 1.0)
             homeViewModelMock.currentProduction = production
             try view.find(viewWithId: HomeConstants.formId).refreshable()

             let totalSolar = try view.find(viewWithId: HomeConstants.totalSolarId)
                 .labeledContent().text(0).string()
             let useInLocal = try view.find(viewWithId: HomeConstants.useInLocalId)
                 .labeledContent().text(0).string()
             let exportToGrid = try view.find(viewWithId: HomeConstants.exportToGridId)
                 .labeledContent().text(0).string()
             let importFromGrid = try view.find(viewWithId: HomeConstants.importFromGridId)
                 .labeledContent().text(0).string()

             XCTAssertEqual(totalSolar, "\(production.totalSolar) W")
             XCTAssertEqual(useInLocal, "\(production.useInLocal) W")
             XCTAssertEqual(exportToGrid, "\(production.exportToGrid) W")
             XCTAssertEqual(importFromGrid, "\(production.importFromGrid) W")
         }
     }*/
}
