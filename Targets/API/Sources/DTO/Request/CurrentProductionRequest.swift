//
//  CurrentProductionRequest.swift
//  api
//
//  Created by Eric Gimenez on 14/6/22.
//  Copyright © 2022 eric.gimenez.galera. All rights reserved.
//

import CryptoKit
import Foundation

struct CurrentProductionRequest: Codable, Equatable {
    let plantId: String
    let datalogSerialNumber: String
    let address: String = "1"

    init(datalogSerialNumber: String) throws {
        plantId = try PlantIdManager.obtain()
        self.datalogSerialNumber = datalogSerialNumber
    }

    enum CodingKeys: String, CodingKey {
        case plantId
        case datalogSerialNumber = "datalogSn"
        case address = "addr"
    }
}
