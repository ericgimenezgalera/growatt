//
//  ViewModel.swift
//  UIFramework
//
//  Created by Eric Gimènez Galera on 14/9/23.
//  Copyright © 2023 eric.gimenez.galera. All rights reserved.
//

import Foundation

class ViewModel: ObservableObject {
    var tasks: [Task<Void, Never>] = []

    deinit {
        for task in tasks {
            task.cancel()
        }
    }
}
