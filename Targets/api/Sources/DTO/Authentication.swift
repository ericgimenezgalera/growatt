//
//  Authentication.swift
//  api
//
//  Created by Eric Gimenez on 14/6/22.
//  Copyright © 2022 eric.gimenez.galera. All rights reserved.
//

import CryptoKit
import Foundation

public struct Authentication: Codable, Equatable {
    public let account: String
    public let password: String

    public init(account: String, password: String) {
        self.account = account
        self.password = password
    }

    public enum CodingKeys: String, CodingKey {
        case account
        case password
    }
}
