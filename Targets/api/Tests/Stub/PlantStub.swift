//
//  PlantStub.swift
//  APITests
//
//  Created by Eric Gimenez on 15/6/22.
//  Copyright © 2022 eric.gimenez.galera. All rights reserved.
//

@testable import API
import Foundation

extension Plant {
    static func makeStub() -> Plant {
        Plant(name: "fakePlantName", id: "fakePlantID")
    }

    static func makeStub(name: String, id: String) -> Plant {
        Plant(name: name, id: id)
    }
}
