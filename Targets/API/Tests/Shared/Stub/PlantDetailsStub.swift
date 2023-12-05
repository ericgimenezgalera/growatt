//
//  PlantDetailsStub.swift
//  APITests
//
//  Created by Eric Gimenez on 15/6/22.
//  Copyright © 2022 eric.gimenez.galera. All rights reserved.
//

@testable import API
import Foundation

extension PlantDetails {
    static func makeStub() -> PlantDetails {
        PlantDetails(
            name: "Fake name",
            power: 9999,
            datalogType: "Fake type",
            datalogSerialNumber: "Fake datalog serial number",
            inverterModel: "Fake inverter Model",
            inverterSerialNumber: "Fake inverter serial number"
        )
    }
}
