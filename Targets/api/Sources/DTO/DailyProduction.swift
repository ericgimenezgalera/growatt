//
//  DailyProduction.swift
//  API
//
//  Created by Eric Gimènez Galera on 4/10/23.
//  Copyright © 2023 eric.gimenez.galera. All rights reserved.
//

import Foundation

public struct DailyProduction: Codable, Equatable {
    // All metrics are on W
    public let totalSolar: Double
    public let selfConsumed: Double
    public let exportedToGrid: Double
    public let importedFromGrid: Double
    public let totalLocal: Double

    public enum CodingKeys: String, CodingKey {
        case totalSolar = "epvToday"
        case selfConsumed = "eselfToday"
        case exportedToGrid = "etoGridToday"
        case importedFromGrid = "gridPowerToday"
        case totalLocal = "elocalLoadToday"
    }

    public init(
        totalSolar: Double,
        selfConsumed: Double,
        exportedToGrid: Double,
        importedFromGrid: Double,
        totalLocal: Double
    ) {
        self.totalSolar = totalSolar
        self.selfConsumed = selfConsumed
        self.exportedToGrid = exportedToGrid
        self.importedFromGrid = importedFromGrid
        self.totalLocal = totalLocal
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let totalSolarString = try container.decode(String.self, forKey: .totalSolar)
        totalSolar = try Self.parseStringToDouble(totalSolarString)
        let selfConsumedString = try container.decode(String.self, forKey: .selfConsumed)
        selfConsumed = try Self.parseStringToDouble(selfConsumedString)
        let exportedToGridString = try container.decode(String.self, forKey: .exportedToGrid)
        exportedToGrid = try Self.parseStringToDouble(exportedToGridString)
        let importedFromGridString = try container.decode(String.self, forKey: .importedFromGrid)
        importedFromGrid = try Self.parseStringToDouble(importedFromGridString)
        let totalLocalString = try container.decode(String.self, forKey: .totalLocal)
        totalLocal = try Self.parseStringToDouble(totalLocalString)
    }

    private static func parseStringToDouble(_ string: String) throws -> Double {
        if let double = Double(string) {
            return double
        } else {
            throw ProductionServiceError.invalidProductionValue(string)
        }
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode("\(totalSolar)", forKey: .totalSolar)
        try container.encode("\(selfConsumed)", forKey: .selfConsumed)
        try container.encode("\(exportedToGrid)", forKey: .exportedToGrid)
        try container.encode("\(importedFromGrid)", forKey: .importedFromGrid)
        try container.encode("\(totalLocal)", forKey: .totalLocal)
    }
}
