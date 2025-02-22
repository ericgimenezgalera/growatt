//
//  AppearAsyncHandler.swift
//  Growatt
//
//  Created by Eric Gimenez on 16/2/25.
//  Copyright © 2025 eric.gimenez.galera. All rights reserved.
//

import SwiftUI

struct AppearAsyncHandler: UIViewControllerRepresentable {
    func makeCoordinator() -> AppearAsyncHandler.Coordinator {
        Coordinator(onAppear: onAppear)
    }

    let onAppear: () async -> Void

    func makeUIViewController(context: UIViewControllerRepresentableContext<AppearAsyncHandler>) -> UIViewController {
        context.coordinator
    }

    func updateUIViewController(
        _: UIViewController,
        context _: UIViewControllerRepresentableContext<AppearAsyncHandler>
    ) {}

    typealias UIViewControllerType = UIViewController

    class Coordinator: UIViewController {
        let onAppear: () async -> Void

        init(onAppear: @escaping () async -> Void) {
            self.onAppear = onAppear
            super.init(nibName: nil, bundle: nil)
        }

        required init?(coder _: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }

        override func viewDidAppear(_ animated: Bool) {
            super.viewDidAppear(animated)
            Task { @MainActor in
                await onAppear()
            }
        }
    }
}

struct AppearAsyncModifier: ViewModifier {
    let callback: () async -> Void

    func body(content: Content) -> some View {
        content
            .background(AppearAsyncHandler(onAppear: callback))
    }
}

public extension View {
    func onAppear(_ perform: @escaping () async -> Void) -> some View {
        modifier(AppearAsyncModifier(callback: perform))
    }
}
