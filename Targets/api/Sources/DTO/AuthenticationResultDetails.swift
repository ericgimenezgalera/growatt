//
//  AuthenticationResultDetails.swift
//  API
//
//  Created by Eric Gimenez on 15/6/22.
//  Copyright © 2022 eric.gimenez.galera. All rights reserved.
//

import Foundation

public struct AuthenticationResultDetails: Codable, Equatable {
    public let success: Bool
    public let data: [Plant]?
    
    public enum CodingKeys: String, CodingKey {
        case success
        case data
    }
}
