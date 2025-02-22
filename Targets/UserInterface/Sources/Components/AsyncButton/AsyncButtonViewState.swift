//
//  AsyncButtonViewState.swift
//  Growatt
//
//  Created by Eric Gimenez on 15/2/25.
//  Copyright © 2025 eric.gimenez.galera. All rights reserved.
//

import Foundation

class AsyncButtonViewState: ObservableObject {
    @Published var showProgressView = false
    let buttonId: String
    var action: (() async -> Void)?

    init(buttonId: String = "buttonId") {
        self.buttonId = buttonId
    }
}
