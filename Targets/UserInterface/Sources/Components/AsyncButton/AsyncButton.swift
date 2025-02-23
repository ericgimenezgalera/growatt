//
//  AsyncButton.swift
//  Growatt
//
//  Created by Eric Gimenez on 15/2/25.
//  Copyright © 2025 eric.gimenez.galera. All rights reserved.
//

import SwiftUI

struct AsyncButton<Label: View>: View {
    @ObservedObject var viewState: AsyncButtonViewState
    @ViewBuilder var label: () -> Label

    var body: some View {
        Button(
            action: {
                Task {
                    var progressViewTask: Task<Void, Error>?

                    progressViewTask = Task {
                        try await Task.sleep(nanoseconds: 150_000_000)
                        viewState.showProgressView = true
                    }

                    await viewState.action?()
                    progressViewTask?.cancel()
                    viewState.showProgressView = false
                }
            },
            label: {
                label()
            }
        ).accessibilityLabel(viewState.buttonId)
    }
}

extension AsyncButton where Label == Text {
    init(_ label: String, viewState: AsyncButtonViewState) {
        self.init(viewState: viewState) {
            Text(label)
        }
    }
}

extension AsyncButton where Label == Image {
    init(systemImageName: String, viewState: AsyncButtonViewState) {
        self.init(viewState: viewState) {
            Image(systemName: systemImageName)
        }
    }
}
