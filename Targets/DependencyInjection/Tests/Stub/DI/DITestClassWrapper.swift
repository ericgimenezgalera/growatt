//
//  DITestClassWrapper.swift
//  Growatt
//
//  Created by Eric Gimènez Galera on 26/9/23.
//  Copyright © 2023 eric.gimenez.galera. All rights reserved.
//

import DependencyInjection
import Foundation

private struct TestClassKey: InjectionKey {
    static var currentValue: TestClass = TestClassA()
}

extension InjectedValues {
    var testClass: TestClass {
        get { Self[TestClassKey.self] }
        set { Self[TestClassKey.self] = newValue }
    }
}
