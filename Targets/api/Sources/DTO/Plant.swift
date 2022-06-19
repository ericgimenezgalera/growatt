//
//  Plant.swift
//  API
//
//  Created by Eric Gimenez on 15/6/22.
//  Copyright © 2022 eric.gimenez.galera. All rights reserved.
//

import Foundation

public struct Plant: Codable, Equatable {
    public let name: String
    public let id: String
    
    public enum CodingKeys: String, CodingKey {
        case name = "plantName"
        case id = "plantId"
    }
}
