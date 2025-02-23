//
//  HomePage.swift
//  Growatt
//
//  Created by Eric Gimenez on 23/2/25.
//  Copyright © 2025 eric.gimenez.galera. All rights reserved.
//

@testable import UserInterface
import XCTest

class HomePage: BasePage {
    private let settingsTab = Element(id: MenuConstants.settings, type: .button)

    init() {
        super.init(rootElement: .init(id: HomeConstants.treeId, type: .staticText))
    }

    func changeToSettings() -> SettingsPage {
        settingsTab.waitForElement()

        settingsTab.tap()
        return .init()
    }
}
