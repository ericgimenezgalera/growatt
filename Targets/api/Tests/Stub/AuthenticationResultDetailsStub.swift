//
//  AuthenticationResultDetailsStub.swift
//  APITests
//
//  Created by Eric Gimenez on 15/6/22.
//  Copyright © 2022 eric.gimenez.galera. All rights reserved.
//

@testable import API
import Foundation

extension AuthenticationResultDetails {
    static func makeStub() -> AuthenticationResultDetails {
        AuthenticationResultDetails(success: true, data: [Plant.makeStub()])
    }

    static func makeStub(success: Bool, data: [Plant]?) -> AuthenticationResultDetails {
        AuthenticationResultDetails(success: success, data: data)
    }
}
