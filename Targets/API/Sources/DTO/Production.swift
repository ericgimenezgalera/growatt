//
//  Production.swift
//  API
//
//  Created by Eric Gimènez Galera on 4/10/23.
//  Copyright © 2023 eric.gimenez.galera. All rights reserved.
//

import Foundation

public struct Production: Codable, Equatable {
    // All metrics are on W
    public let totalSolar: Double
    public let exportToGrid: Double
    public let useInLocal: Double
    public let importFromGrid: Double

    public enum CodingKeys: String, CodingKey {
        case totalSolar = "ppv"
        case exportToGrid = "pactogridKw"
        case importFromGrid = "pactouserKw"
        case useInLocal = "pLocalLoad"
    }

    public init(
        totalSolar: Double,
        exportToGrid: Double,
        importFromGrid: Double,
        useInLocal: Double
    ) {
        self.totalSolar = totalSolar
        self.exportToGrid = exportToGrid
        self.importFromGrid = importFromGrid
        self.useInLocal = useInLocal
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let totalSolarString = try container.decode(String.self, forKey: .totalSolar)
        totalSolar = try Self.parseStringToDouble(totalSolarString)
        let exportToGridString = try container.decode(String.self, forKey: .exportToGrid)
        exportToGrid = try Self.parseStringToDouble(exportToGridString)
        let importFromGridString = try container.decode(String.self, forKey: .importFromGrid)
        importFromGrid = try Self.parseStringToDouble(importFromGridString)
        let useInLocalString = try container.decode(String.self, forKey: .useInLocal)
        useInLocal = try Self.parseStringToDouble(useInLocalString)
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
        try container.encode("\(exportToGrid)", forKey: .exportToGrid)
        try container.encode("\(importFromGrid)", forKey: .importFromGrid)
        try container.encode("\(useInLocal)", forKey: .useInLocal)
    }
}
