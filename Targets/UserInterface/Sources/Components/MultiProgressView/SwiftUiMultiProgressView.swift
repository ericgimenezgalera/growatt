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

struct SwiftUiMultiProgressViewImpl<T: ProgressViewStorageType>: UIViewRepresentable {
    typealias UIViewType = FullMultiProgressView<T>
    private let view: FullMultiProgressView<T>

    init(viewState: FullMultiProgressView<T>.ViewState) {
        view = FullMultiProgressView<T>(viewState: viewState)
    }

    func makeUIView(context _: Context) -> FullMultiProgressView<T> {
        return view
    }

    func updateUIView(_: FullMultiProgressView<T>, context _: Context) {
        // Updates the state of the specified view with new information from SwiftUI.
    }
}
