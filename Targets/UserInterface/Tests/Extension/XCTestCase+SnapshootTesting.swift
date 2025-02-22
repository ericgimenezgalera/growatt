//
//  XCTestCase+SnapshootTesting.swift
//  Growatt
//
//  Created by Eric Gimenez on 22/2/25.
//  Copyright © 2025 eric.gimenez.galera. All rights reserved.
//

import SnapshotTesting
import SwiftUI
import XCTest

extension XCTestCase {
    private var scale: String {
        let scale: Float! = Float(UIScreen.main.scale)
        return String(Int(scale))
    }

    private var device: String {
        UIDevice.current.model
    }

    public func assertNamedSnapshot<Value>(
        matching view: @autoclosure () -> Value,
        size: CGSize,
        record recording: Bool = false,
        timeout: TimeInterval = 5,
        file: StaticString = #file,
        testName: String = #function,
        line: UInt = #line
    ) where Value: View {
        let name = "\(device)-\(scale)"
        assertSnapshot(
            of: UIHostingController(rootView: view()),
            as: .image(precision: 0.97, size: size),
            named: name,
            record: recording,
            timeout: timeout,
            file: file,
            testName: testName,
            line: line
        )
    }
}
