//
//  DITest.swift
//  APITests
//
//  Created by Eric Gimenez on 16/6/22.
//  Copyright © 2022 eric.gimenez.galera. All rights reserved.
//

@testable import DIFramework
import Foundation
import XCTest

final class DITest: XCTestCase {
    override func setUp() {
        InjectedValues[\.testClass] = TestClassA()
    }

    func testDIDefaultValue() async throws {
        XCTAssertEqual(TestClassWrapper().testClass.value, TestClassA().value)
    }

    func testDIChangeValue() async throws {
        InjectedValues[\.testClass] = TestClassB()

        XCTAssertEqual(TestClassWrapper().testClass.value, TestClassB().value)
    }
}
