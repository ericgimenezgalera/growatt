//
//  CustomMultiProgressViewDataSource.swift
//  UserInterface
//
//  Created by Eric Gimènez Galera on 11/10/23.
//  Copyright © 2023 eric.gimenez.galera. All rights reserved.
//

import Foundation
import MultiProgressView

class CustomMultiProgressViewDataSource<T: ProgressViewStorageType>: MultiProgressViewDataSource {
    func numberOfSections(in _: MultiProgressView) -> Int {
        T.allCases.count
    }

    func progressView(_: MultiProgressView, viewForSection section: Int) -> ProgressViewSection {
        let bar = StorageProgressSection()
        bar.configure(withStorageType: T(rawValue: section))
        return bar
    }
}
