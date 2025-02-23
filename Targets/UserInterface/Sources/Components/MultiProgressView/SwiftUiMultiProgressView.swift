//
//  SwiftUiMultiProgressView.swift
//  UserInterface
//
//  Created by Eric Gimènez Galera on 10/10/23.
//  Copyright © 2023 eric.gimenez.galera. All rights reserved.
//

import Foundation
import MultiProgressView
import SwiftUI

struct SwiftUiMultiProgressViewImpl: UIViewRepresentable {
    typealias UIViewType = MultiProgressView
    private let view: MultiProgressView

    init<T>(dataSource: CustomMultiProgressViewDataSource<T>) {
        view = MultiProgressView()
        view.dataSource = dataSource
    }

    func makeUIView(context _: Context) -> MultiProgressView {
        return view
    }

    func updateUIView(_: MultiProgressView, context _: Context) {
        // Updates the state of the specified view with new information from SwiftUI.
    }

    @MainActor
    public func updateData(section: Int, to progress: Float) async {
        UIView.animate(withDuration: 0.5) { [self] in
            view.setProgress(section: section, to: progress)
        }
    }

    @MainActor
    public func resetProgress() async {
        UIView.animate(withDuration: 0.5) { [self] in
            view.resetProgress()
        }
    }

    public func progress(forSection section: Int) -> Float {
        view.progress(forSection: section)
    }
}
