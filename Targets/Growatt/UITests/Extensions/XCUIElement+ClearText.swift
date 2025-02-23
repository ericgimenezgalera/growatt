//
//  XCUIElement+ClearText.swift
//  Growatt
//
//  Created by Eric Gimenez on 23/2/25.
//  Copyright © 2025 eric.gimenez.galera. All rights reserved.
//
import XCTest

extension XCUIElement {
    func clearText() {
        guard let stringValue = value as? String else {
            return
        }
        var deleteString = String()
        for _ in stringValue {
            deleteString += XCUIKeyboardKey.delete.rawValue
        }
        typeText(deleteString)
    }
}
