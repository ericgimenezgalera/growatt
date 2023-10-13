//
//  StorageStackView.swift
//  UserInterface
//
//  Created by Eric Gimènez Galera on 11/10/23.
//  Copyright © 2023 eric.gimenez.galera. All rights reserved.
//

import Foundation
import UIKit

class StorageStackView: UIStackView {
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 11)
        return label
    }()

    private lazy var colorView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = colorViewHeight / 4
        view.layer.masksToBounds = true
        return view
    }()

    private let colorViewHeight: CGFloat = 11

    init(storageType: any ProgressViewStorageType) {
        super.init(frame: .zero)
        alignment = .fill
        spacing = 6

        addArrangedSubview(colorView)
        colorView.anchor(width: colorViewHeight, height: colorViewHeight)
        colorView.backgroundColor = storageType.color

        addArrangedSubview(titleLabel)
        titleLabel.text = storageType.description
    }

    required init(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
