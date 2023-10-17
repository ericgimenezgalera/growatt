//
//  BaseViewModelTest.swift
//  UserInterfaceTests
//
//  Created by Eric Gimènez Galera on 16/10/23.
//  Copyright © 2023 eric.gimenez.galera. All rights reserved.
//

import Foundation
@testable import UserInterface
import XCTest

class BaseViewModelTest<T: ViewModel>: XCTestCase {
    var viewModel: T!

    func waitForFinishedTask(execute: @escaping (T) -> Void) {
        let completaionExpectation = expectation(description: "Completion task")

        Task {
            execute(viewModel)

            switch await viewModel.tasks.first?.result {
            case .success:
                completaionExpectation.fulfill()
            default:
                XCTFail("Not success task")
            }
        }

        wait(for: [completaionExpectation])
    }
}
