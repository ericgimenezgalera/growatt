//
//  SwiftUiMultiProgressViewMock.swift
//  UserInterfaceTests
//
//  Created by Eric Gimènez Galera on 13/10/23.
//  Copyright © 2023 eric.gimenez.galera. All rights reserved.
//

import Foundation
@testable import UserInterface

class SwiftUiMultiProgressViewMock: SwiftUiMultiProgressView {
    var updatedDataCalls: [(Int, Float)] = []

    func updateData(section: Int, to progress: Float) {
        updatedDataCalls.append((section, progress))
    }

    func resetProgress() {}
}
