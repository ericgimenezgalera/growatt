//
//  PlantDetails.swift
//  API
//
//  Created by Eric Gimènez Galera on 4/10/23.
//  Copyright © 2023 eric.gimenez.galera. All rights reserved.
//

import Foundation

public struct PlantDetails: Codable, Equatable {
    public let name: String
    // Power on W
    public let power: Int
    public let datalogType: String
    public let deviceModel: String
    public let serialNumber: String

    public enum CodingKeys: String, CodingKey {
        case name = "plantName"
        case power = "nominalPower"
        case datalogType = "datalogTypeTest"
        case deviceModel
        case serialNumber = "sn"
    }

    public init(
        name: String,
        power: Int,
        datalogType: String,
        deviceModel: String,
        serialNumber: String
    ) {
        self.name = name
        self.power = power
        self.datalogType = datalogType
        self.deviceModel = deviceModel
        self.serialNumber = serialNumber
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        name = try container.decode(String.self, forKey: .name)
        let stringPower = try container.decode(String.self, forKey: .power)
        power = Int(stringPower) ?? -1
        datalogType = try container.decode(String.self, forKey: .datalogType)
        deviceModel = try container.decode(String.self, forKey: .deviceModel)
        serialNumber = try container.decode(String.self, forKey: .serialNumber)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(name, forKey: .name)
        try container.encode("\(power)", forKey: .power)
        try container.encode(datalogType, forKey: .datalogType)
        try container.encode(deviceModel, forKey: .deviceModel)
        try container.encode(serialNumber, forKey: .serialNumber)
    }
}
