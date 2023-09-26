//
//  TestClassWrapper.swift
//  Growatt
//
//  Created by Eric Gimènez Galera on 26/9/23.
//  Copyright © 2023 eric.gimenez.galera. All rights reserved.
//

import DependencyInjection
import Foundation

class TestClassWrapper {
    @Injected(\.testClass) var testClass: TestClass
}
