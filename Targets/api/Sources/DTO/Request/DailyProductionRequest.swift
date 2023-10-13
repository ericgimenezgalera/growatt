//
//  DailyProductionRequest.swift
//  api
//
//  Created by Eric Gimenez on 14/6/22.
//  Copyright © 2022 eric.gimenez.galera. All rights reserved.
//

import CryptoKit
import Foundation

struct DailyProductionRequest: Codable, Equatable {
    public let plantId: String
    public let datalogSerialNumber: String
    public let inverterSerialNumber: String
    public let address: String = "1"

    init(datalogSerialNumber: String, inverterSerialNumber: String) throws {
        plantId = try PlantIdManager.obtain()
        self.datalogSerialNumber = datalogSerialNumber
        self.inverterSerialNumber = inverterSerialNumber
    }

    enum CodingKeys: String, CodingKey {
        case plantId
        case datalogSerialNumber = "datalogSn"
        case inverterSerialNumber = "InvId"
        case address = "addr"
    }
}
