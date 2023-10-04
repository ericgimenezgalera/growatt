//
//  PlantListResponse.swift
//  API
//
//  Created by Eric Gimènez Galera on 4/10/23.
//  Copyright © 2023 eric.gimenez.galera. All rights reserved.
//

import Foundation

struct PlantListResponseDetails: Codable, Equatable {
    let datas: [PlantDetails]

    enum CodingKeys: String, CodingKey {
        case datas
    }
}

struct PlantListResponse: Codable, Equatable {
    let result: Int
    let obj: PlantListResponseDetails

    enum CodingKeys: String, CodingKey {
        case result
        case obj
    }
}
