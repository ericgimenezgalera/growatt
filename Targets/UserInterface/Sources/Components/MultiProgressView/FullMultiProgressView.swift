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

public class FullMultiProgressView<T: ProgressViewStorageType>: UIView {
    public class ViewState: ObservableObject {
        let multiProgressViewDataSource = CustomMultiProgressViewDataSource<T>()
        let progressView = MultiProgressView()
        let title: String

        @MainActor
        public func updateData(section: Int, to progress: Float) async {
            UIView.animate(withDuration: 0.5) { [self] in
                progressView.setProgress(section: section, to: progress)
            }
        }

        @MainActor
        public func resetProgress() async {
            UIView.animate(withDuration: 0.5) { [self] in
                progressView.resetProgress()
            }
        }

        public init(title: String) {
            self.title = title
            progressView.dataSource = multiProgressViewDataSource
        }
    }

    @ObservedObject var viewState: ViewState

    private let padding: CGFloat = 15
    private let progressViewHeight: CGFloat = 20
    init(viewState: ViewState) {
        self.viewState = viewState
        super.init(frame: CGRect())
        initialize()
    }

    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func initialize() {
        backgroundColor = .clear
        let titleLabel = makeTitleLabel()
        makeMultiProgressView(topView: titleLabel)
        makeStackView(topView: viewState.progressView)
    }

    @discardableResult
    private func makeTitleLabel() -> UILabel {
        let titleLabel = UILabel()
        titleLabel.text = viewState.title
        titleLabel.font = UIFont.systemFont(ofSize: 14)
        addSubview(titleLabel)
        titleLabel.anchor(
            top: topAnchor,
            paddingTop: padding,
            centerX: centerXAnchor
        )
        return titleLabel
    }

    private func makeMultiProgressView(topView: UIView) {
        viewState.progressView.trackBackgroundColor = UIColor.progressViewBackground
        viewState.progressView.lineCap = .round
        viewState.progressView.cornerRadius = progressViewHeight / 4
        addSubview(viewState.progressView)
        viewState.progressView.anchor(
            top: topView.bottomAnchor,
            left: leftAnchor,
            right: rightAnchor,
            paddingTop: padding,
            paddingLeft: padding,
            paddingRight: padding,
            height: progressViewHeight
        )
    }

    @discardableResult
    private func makeStackView(topView: UIView) -> UIStackView {
        let stackView = UIStackView()
        stackView.distribution = .equalSpacing
        stackView.alignment = .center

        addSubview(stackView)
        stackView.anchor(
            top: topView.bottomAnchor,
            left: leftAnchor,
            bottom: bottomAnchor,
            right: rightAnchor,
            paddingTop: padding,
            paddingLeft: padding,
            paddingBottom: padding,
            paddingRight: padding
        )

        for type in T.allCases {
            stackView.addArrangedSubview(StorageStackView(storageType: type))
        }

        stackView.addArrangedSubview(UIView())

        return stackView
    }
}
