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

protocol SwiftUiMultiProgressView {
    func updateData(section: Int, to progress: Float)
    func resetProgress()
}

struct SwiftUiMultiProgressViewImpl<T: ProgressViewStorageType>: UIViewRepresentable, SwiftUiMultiProgressView {
    typealias UIViewType = FullMultiProgressView<T>
    private let view: FullMultiProgressView<T>

    init(_ title: String) {
        view = FullMultiProgressView(title)
    }

    func makeUIView(context _: Context) -> FullMultiProgressView<T> {
        return view
    }

    func updateUIView(_: FullMultiProgressView<T>, context _: Context) {
        // Updates the state of the specified view with new information from SwiftUI.
    }

    func updateData(section: Int, to progress: Float) {
        UIView.animate(withDuration: 0.5) {
            view.updateData(section: section, to: progress)
        }
    }

    func resetProgress() {
        UIView.animate(withDuration: 0.5) {
            view.resetProgress()
        }
    }
}
