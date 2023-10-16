//
//  BaseViewTest.swift
//  UserInterface
//
//  Created by Eric Gimènez Galera on 15/10/23.
//  Copyright © 2023 eric.gimenez.galera. All rights reserved.
//

import Foundation
import SwiftUI
@testable import UserInterface
import ViewInspector
import XCTest

class BaseViewTest<T: BaseView>: XCTestCase {
    var view: T!

    func onAppearView(_ perform: @escaping ((InspectableView<ViewType.ClassifiedView>) throws -> Void)) {
        let exp = view.on(\.didAppear) { view in
            try perform(view.actualView().inspect())
        }
        ViewHosting.host(view: view)
        wait(for: [exp], timeout: 0.1)
    }
}
