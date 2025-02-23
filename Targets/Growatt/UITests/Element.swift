//
//  Element.swift
//  Growatt
//
//  Created by Eric Gimenez on 23/2/25.
//  Copyright © 2025 eric.gimenez.galera. All rights reserved.
//
import XCTest

class Element {
    let id: String
    let type: XCUIElement.ElementType
    var element: XCUIElement?

    init(id: String, type: XCUIElement.ElementType) {
        self.id = id
        self.type = type
    }

    func waitForElement(_ timeout: TimeInterval = 5) {
        for _ in 0 ..< max(Int(timeout) * 4, 1) {
            let currentApp = XCUIApplication()
            let element = currentApp.descendants(matching: type)[id]
            if element.waitForExistence(timeout: 0.25) {
                self.element = element
                return
            }
        }
    }

    func typeText(text: String) {
        guard let element else {
            XCTFail(#function + ": Element not found")
            return
        }

        element.tap()
        element.clearText()
        element.typeText(text)
    }

    func tap() {
        guard let element else {
            XCTFail(#function + ": Element not found")
            return
        }

        element.tap()
    }
}
