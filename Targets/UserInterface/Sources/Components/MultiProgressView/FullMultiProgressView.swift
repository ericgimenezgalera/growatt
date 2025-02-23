//
//  FullMultiProgressView.swift
//  UserInterface
//
//  Created by Eric Gimènez Galera on 10/10/23.
//  Copyright © 2023 eric.gimenez.galera. All rights reserved.
//

import Foundation
import MultiProgressView
import SwiftUI

public struct FullMultiProgressView<T: ProgressViewStorageType>: View {
    public class ViewState: ObservableObject {
        @Published var progressView = SwiftUiMultiProgressViewImpl(dataSource: CustomMultiProgressViewDataSource<T>())
        let title: String

        public init(title: String) {
            self.title = title
        }
    }

    @ObservedObject var viewState: ViewState

    init(viewState: ViewState) {
        self.viewState = viewState
    }

    public var body: some View {
        VStack {
            Text(viewState.title)
                .font(.system(size: 14))

            viewState.progressView
                .background(Color(UIColor.progressViewBackground))
                .cornerRadius(5)
                .frame(maxHeight: 20)
                .padding(.bottom, 15)
                .padding(.horizontal, 15)

            HStack() {
                ForEach(HomeEnergyStorage.allCases, id: \.rawValue) { type in

                    Rectangle()
                        .fill(Color(type.color))
                        .cornerRadius(2)
                        .frame(width: 11, height: 11)

                    Text("\(type.description)")
                        .font(.system(size: 11))
                        .padding(.trailing, 15)
                }
            }
        }
    }
}

#Preview {
    let viewState = FullMultiProgressView<HomeEnergyStorage>.ViewState(title: "Test title")
    Task { @MainActor in
        await viewState.progressView.updateData(section: 0, to: 0.3)
        await viewState.progressView.updateData(section: 1, to: 0.7)
    }
    return FullMultiProgressView(viewState: viewState)
}
