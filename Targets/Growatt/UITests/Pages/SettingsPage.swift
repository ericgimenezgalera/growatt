//
//  SettingsPage.swift
//  Growatt
//
//  Created by Eric Gimenez on 23/2/25.
//  Copyright © 2025 eric.gimenez.galera. All rights reserved.
//

@testable import UserInterface
import XCTest

class SettingsPage: BasePage {
    private let homeTab = Element(id: MenuConstants.home, type: .button)

    init() {
        super.init(rootElement: .init(id: SettingsConstants.logoutId, type: .button))
    }

    func changeToHome() -> HomePage {
        homeTab.waitForElement()

        homeTab.tap()
        return .init()
    }
}
