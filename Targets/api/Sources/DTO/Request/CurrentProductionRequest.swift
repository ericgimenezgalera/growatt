//
//  CurrentProductionRequest.swift
//  api
//
//  Created by Eric Gimenez on 14/6/22.
//  Copyright © 2022 eric.gimenez.galera. All rights reserved.
//

import CryptoKit
import Foundation

struct CurrentProductionRequest: Codable, Equatable {
    public let plantId: String
    public let datalogSerialNumber: String
    public let address: String = "1"

    init(datalogSerialNumber: String) throws {
        let cookies = HTTPCookieStorage.shared.cookies?.filter { cookie in
            cookie.name == "onePlantId"
        }

        guard cookies?.count == 1, let plantId = cookies?.first?.value else {
            throw ProductionServiceError.noPlantId
        }

        self.plantId = plantId
        self.datalogSerialNumber = datalogSerialNumber
    }

    enum CodingKeys: String, CodingKey {
        case plantId
        case datalogSerialNumber = "datalogSn"
        case address = "addr"
    }
}
