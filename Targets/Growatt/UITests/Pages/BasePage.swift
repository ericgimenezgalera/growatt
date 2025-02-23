//
//  BasePage.swift
//  Growatt
//
//  Created by Eric Gimenez on 23/2/25.
//  Copyright © 2025 eric.gimenez.galera. All rights reserved.
//

import XCTest

class BasePage {
    var rootElement: Element

    init(rootElement: Element) {
        self.rootElement = rootElement
        rootElement.waitForElement()
        if rootElement.element == nil {
            XCTFail("Root element \(rootElement.id) not found")
        }
    }
}
