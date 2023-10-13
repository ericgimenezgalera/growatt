//
//  SocialContributionResponse.swift
//  API
//
//  Created by Eric Gimènez Galera on 4/10/23.
//  Copyright © 2023 eric.gimenez.galera. All rights reserved.
//

import Foundation

struct SocialContributionResponse: Codable, Equatable {
    let result: Int
    let obj: SocialContribution

    enum CodingKeys: String, CodingKey {
        case result
        case obj
    }
}
