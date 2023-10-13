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

class FullMultiProgressView<T: ProgressViewStorageType>: UIView {
    private let multiProgressViewDataSource = CustomMultiProgressViewDataSource<T>()
    private let padding: CGFloat = 15
    private let progressViewHeight: CGFloat = 20
    private let title: String
    private var progressView: MultiProgressView!

    init(_ title: String) {
        self.title = title
        super.init(frame: CGRect())
        initialize()
    }

    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func initialize() {
        backgroundColor = .clear
        let titleLabel = makeTitleLabel()
        let progressView = makeMultiProgressView(topView: titleLabel)
        self.progressView = progressView
        makeStackView(topView: progressView)
    }

    @discardableResult
    private func makeTitleLabel() -> UILabel {
        let titleLabel = UILabel()
        titleLabel.text = title
        titleLabel.font = UIFont.systemFont(ofSize: 14)
        addSubview(titleLabel)
        titleLabel.anchor(
            top: topAnchor,
            paddingTop: padding,
            centerX: centerXAnchor
        )
        return titleLabel
    }

    @discardableResult
    private func makeMultiProgressView(topView: UIView) -> MultiProgressView {
        let progressView = MultiProgressView()
        progressView.trackBackgroundColor = UIColor.progressViewBackground
        progressView.lineCap = .round
        progressView.cornerRadius = progressViewHeight / 4
        progressView.dataSource = multiProgressViewDataSource
        addSubview(progressView)
        progressView.anchor(
            top: topView.bottomAnchor,
            left: leftAnchor,
            right: rightAnchor,
            paddingTop: padding,
            paddingLeft: padding,
            paddingRight: padding,
            height: progressViewHeight
        )
        return progressView
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

    func updateData(section: Int, to progress: Float) {
        progressView.setProgress(section: section, to: progress)
    }

    func resetProgress() {
        progressView.resetProgress()
    }
}
