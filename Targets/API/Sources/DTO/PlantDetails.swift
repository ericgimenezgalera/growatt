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
    public let datalogSerialNumber: String
    public let inverterModel: String
    public let inverterSerialNumber: String

    public enum CodingKeys: String, CodingKey {
        case name = "plantName"
        case power = "nominalPower"
        case datalogType = "datalogTypeTest"
        case datalogSerialNumber = "datalogSn"
        case inverterModel = "deviceModel"
        case inverterSerialNumber = "sn"
    }

    public init(
        name: String,
        power: Int,
        datalogType: String,
        datalogSerialNumber: String,
        inverterModel: String,
        inverterSerialNumber: String
    ) {
        self.name = name
        self.power = power
        self.datalogType = datalogType
        self.datalogSerialNumber = datalogSerialNumber
        self.inverterModel = inverterModel
        self.inverterSerialNumber = inverterSerialNumber
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        name = try container.decode(String.self, forKey: .name)
        let stringPower = try container.decode(String.self, forKey: .power)
        power = Int(stringPower) ?? -1
        datalogType = try container.decode(String.self, forKey: .datalogType)
        datalogSerialNumber = try container.decode(String.self, forKey: .datalogSerialNumber)
        inverterModel = try container.decode(String.self, forKey: .inverterModel)
        inverterSerialNumber = try container.decode(String.self, forKey: .inverterSerialNumber)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(name, forKey: .name)
        try container.encode("\(power)", forKey: .power)
        try container.encode(datalogType, forKey: .datalogType)
        try container.encode(datalogSerialNumber, forKey: .datalogSerialNumber)
        try container.encode(inverterModel, forKey: .inverterModel)
        try container.encode(inverterSerialNumber, forKey: .inverterSerialNumber)
    }
}
