//
//  SocialContributionStub.swift
//  APITests
//
//  Created by Eric Gimenez on 15/6/22.
//  Copyright © 2022 eric.gimenez.galera. All rights reserved.
//

@testable import API
import Foundation

extension SocialContribution {
    static func makeStub() -> SocialContribution {
        SocialContribution(co2: 12345, tree: 55555, coal: 98765)
    }
}
