//
//  DIKeychainWrapper.swift
//  API
//
//  Created by Eric Gimènez Galera on 26/9/23.
//  Copyright © 2023 eric.gimenez.galera. All rights reserved.
//

import DependencyInjection
import Foundation

private struct KeychainWrapperKey: InjectionKey {
    static var currentValue: KeychainWrapper = KeychainWraperImpl()
}

public extension InjectedValues {
    var keychainWrapper: KeychainWrapper {
        get { Self[KeychainWrapperKey.self] }
        set { Self[KeychainWrapperKey.self] = newValue }
    }
}
