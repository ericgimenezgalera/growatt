//
//  AuthenticationResult.swift
//  api
//
//  Created by Eric Gimenez on 14/6/22.
//  Copyright © 2022 eric.gimenez.galera. All rights reserved.
//

import Foundation

public struct AuthenticationResult: Codable, Equatable {
    public let back: AuthenticationResultDetails

    public enum CodingKeys: String, CodingKey {
        case back
    }
}
