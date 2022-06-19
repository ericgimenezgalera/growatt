//
//  PlantService.swift
//  API
//
//  Created by Eric Gimenez on 15/6/22.
//  Copyright © 2022 eric.gimenez.galera. All rights reserved.
//

import Foundation

public protocol PlantService {
    func list() async throws -> String
}

extension ConnectionManager: PlantService {
    public func list() async throws -> String {
        try await ConnectionManager.Builder(self)
            .addUrlSubPath(path: "PlantListAPI.do")
            .addAuthentication()
            .httpMethod(.get)
            .validStatusCode(200)
            .debugDoRequest()
    }
}
