//
//  XCUITests.swift
//  Growatt
//
//  Created by Eric Gimenez on 23/2/25.
//  Copyright © 2025 eric.gimenez.galera. All rights reserved.
//
import XCTest

final class XCUITests: XCTestCase {
    var app: XCUIApplication!
    let springboard = XCUIApplication(bundleIdentifier: "com.apple.springboard")
    // Set correct username and password before run the test
    let username = "username"
    let password = "correct password"

    override func setUp() {
        XCUIDevice.shared.orientation = .portrait
        deleteMyApp()
        app = XCUIApplication()
        app.launch()
    }

    func testNavigateForAllViews() {
        _ = LoginPage()
            .writeUsername(username)
            .writePassword("Test password")
            .tapOnEyeButton()
            .writePassword(password)
            .signIn()
            .changeToSettings()
    }

    func deleteMyApp() {
        XCUIApplication().terminate()

        let bundleDisplayName = "Growatt"

        let icon = springboard.icons[bundleDisplayName]
        if icon.exists {
            if icon.isHittable {
                icon.press(forDuration: 1)
            }

            let buttonRemoveApp = springboard.buttons["Remove App"]
            if buttonRemoveApp.waitForExistence(timeout: 5) {
                buttonRemoveApp.tap()
            }

            let buttonDeleteApp = springboard.alerts.buttons["Delete App"]
            if buttonDeleteApp.waitForExistence(timeout: 5) {
                buttonDeleteApp.tap()
            }

            let buttonDelete = springboard.alerts.buttons["Delete"]
            if buttonDelete.waitForExistence(timeout: 5) {
                buttonDelete.tap()
            }
        }

        guard !springboard.icons[bundleDisplayName].exists else {
            deleteMyApp()
            return
        }
    }
}
