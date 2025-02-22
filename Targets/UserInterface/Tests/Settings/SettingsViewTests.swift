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

final class SettingsViewTests: XCTestCase {
    let fakeUsername = "fake username"
    let fakePlantDetails = PlantDetails.makeStub()
    var view: SettingsView!
    var viewState: SettingsView.ViewState!

    override func setUp() {
        viewState = .init(
            username: "",
            logoutViewState: .init()
        )

        view = .init(viewState: viewState)
    }

    func testInitialState() {
        assertNamedSnapshot(matching: view, size: .init(width: 350, height: 400))
    }

    func testWithPlantDetails() {
        viewState.plantDetails = fakePlantDetails
        assertNamedSnapshot(matching: view, size: .init(width: 350, height: 750))
    }

    func testLoadingBylogout() {
        viewState.plantDetails = fakePlantDetails
        viewState.logoutViewState.showProgressView = true

        assertNamedSnapshot(matching: view, size: .init(width: 350, height: 750))
    }
}
