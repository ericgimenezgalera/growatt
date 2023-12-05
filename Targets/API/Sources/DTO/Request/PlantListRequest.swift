//
//  PlantListRequest.swift
//  api
//
//  Created by Eric Gimenez on 14/6/22.
//  Copyright © 2022 eric.gimenez.galera. All rights reserved.
//

import CryptoKit
import Foundation

struct PlantListRequest: Codable, Equatable {
    public let currPage: String = "1"
    public let plantId: String

    init() throws {
        plantId = try PlantIdManager.obtain()
    }

    enum CodingKeys: String, CodingKey {
        case currPage
        case plantId
    }
}
