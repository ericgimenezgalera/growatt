//
//  SocialContribution.swift
//  API
//
//  Created by Eric Gimènez Galera on 4/10/23.
//  Copyright © 2023 eric.gimenez.galera. All rights reserved.
//

import Foundation

public struct SocialContribution: Codable, Equatable {
    // All metrics are on W
    public let co2: Double
    public let tree: Int
    public let coal: Double

    public enum CodingKeys: String, CodingKey {
        case co2
        case tree
        case coal
    }

    public init(
        co2: Double,
        tree: Int,
        coal: Double
    ) {
        self.co2 = co2
        self.tree = tree
        self.coal = coal
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let co2String = try container.decode(String.self, forKey: .co2)
        co2 = try Self.parseStringToDoble(co2String)
        let treeString = try container.decode(String.self, forKey: .tree)
        tree = try Self.parseStringToInt(treeString)
        let coalString = try container.decode(String.self, forKey: .coal)
        coal = try Self.parseStringToDoble(coalString)
    }

    private static func parseStringToInt(_ string: String) throws -> Int {
        if let int = Int(string) {
            return int
        } else {
            // TODO: change error
            throw ProductionServiceError.invalidProductionValue(string)
        }
    }

    private static func parseStringToDoble(_ string: String) throws -> Double {
        if let double = Double(string) {
            return double
        } else {
            // TODO: change error
            throw ProductionServiceError.invalidProductionValue(string)
        }
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode("\(co2)", forKey: .co2)
        try container.encode("\(tree)", forKey: .tree)
        try container.encode("\(coal)", forKey: .coal)
    }
}
