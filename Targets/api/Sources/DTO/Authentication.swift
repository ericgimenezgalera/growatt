//
//  Authentication.swift
//  api
//
//  Created by Eric Gimenez on 14/6/22.
//  Copyright © 2022 eric.gimenez.galera. All rights reserved.
//

import CryptoKit
import Foundation

public struct Authentication: Codable {
    public let username: String
    public let password: String

    public init(username: String, password: String) {
        self.username = username
        self.password = Self.MD5(password)
    }

    public enum CodingKeys: String, CodingKey {
        case username = "userName"
        case password
    }

    private static func MD5(_ string: String) -> String {
        let messageData = string.data(using: .utf8)!

        return Insecure.MD5.hash(data: messageData).map { String(format: "%02hhx", $0) }.joined()
    }
}
