//
//  SettingsViewTests.swift
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

final class SettingsViewTests: BaseViewTest<SettingsView> {
    let fakeUsername = "fake username"
    var navigationViewModel: NavigationViewModelMock!
    var settingsViewModelMock: SettingsViewModelMock!

    override func setUp() {
        navigationViewModel = NavigationViewModelMock()
        settingsViewModelMock = SettingsViewModelMock()
        view = SettingsView(navigationViewModel, viewModel: settingsViewModelMock)
        UserDefaults.standard.setValue(fakeUsername, forKey: usernameUserDefaultsKey)
    }

    func testInitialState() throws {
        onAppearView { view in
            XCTAssertTrue(self.settingsViewModelMock.getPlantDataCalled)
            let username = try view.find(viewWithId: SettingsConstants.usernameId).text().string()
            _ = try view.find(viewWithId: SettingsConstants.sipnnerId)

            XCTAssertEqual(username, self.fakeUsername)
        }
    }

    func testLogout() throws {
        onAppearView { view in
            XCTAssertFalse(self.settingsViewModelMock.logoutCalled)
            try view.find(viewWithId: SettingsConstants.logoutId).button().tap()
            XCTAssertTrue(self.settingsViewModelMock.logoutCalled)
        }
    }

    func testPlantData() throws {
        let plantDetails = PlantDetails.makeStub()
        settingsViewModelMock.plantDetails = plantDetails
        onAppearView { view in
            XCTAssertThrowsError(try view.find(viewWithId: SettingsConstants.sipnnerId))
            let plantName = try view.find(viewWithId: SettingsConstants.plantNameId).labeledContent().text(0).string()
            let plantPowerId = try view.find(viewWithId: SettingsConstants.plantPowerId).labeledContent().text(0)
                .string()

            let inverterModel = try view.find(viewWithId: SettingsConstants.inverterModelId).labeledContent().text(0)
                .string()
            let inverterSerialNumber = try view.find(viewWithId: SettingsConstants.inverterSerialNumberId)
                .labeledContent().text(0).string()

            let datalogModel = try view.find(viewWithId: SettingsConstants.datalogModelId).labeledContent().text(0)
                .string()
            let datalogSerialNumber = try view.find(viewWithId: SettingsConstants.datalogSerialNumberId)
                .labeledContent().text(0).string()

            XCTAssertEqual(plantName, plantDetails.name)
            XCTAssertEqual(plantPowerId, "\(plantDetails.power) W")

            XCTAssertEqual(inverterModel, plantDetails.inverterModel)
            XCTAssertEqual(inverterSerialNumber, plantDetails.inverterSerialNumber)

            XCTAssertEqual(datalogModel, plantDetails.datalogType)
            XCTAssertEqual(datalogSerialNumber, plantDetails.datalogSerialNumber)
        }
    }
}
