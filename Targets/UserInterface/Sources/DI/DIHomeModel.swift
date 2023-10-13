//
//  DIHomeModel.swift
//  UIFramework
//
//  Created by Eric Gimènez Galera on 14/9/23.
//  Copyright © 2023 eric.gimenez.galera. All rights reserved.
//

import DependencyInjection
import Foundation

private struct HomeModelKey: InjectionKey {
    static var currentValue: HomeModel = HomeModelImpl()
}

extension InjectedValues {
    var homeModel: HomeModel {
        get { Self[HomeModelKey.self] }
        set { Self[HomeModelKey.self] = newValue }
    }
}
