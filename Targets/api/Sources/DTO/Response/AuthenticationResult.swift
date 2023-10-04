//
//  AuthenticationResult.swift
//  api
//
//  Created by Eric Gimenez on 14/6/22.
//  Copyright © 2022 eric.gimenez.galera. All rights reserved.
//

import Foundation

struct AuthenticationResult: Codable, Equatable {
    let result: Int

    enum CodingKeys: String, CodingKey {
        case result
    }
}
