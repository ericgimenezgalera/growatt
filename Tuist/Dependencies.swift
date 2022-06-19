//
//  Dependencies.swift
//  Config
//
//  Created by Eric Gimenez on 13/6/22.
//

import ProjectDescription

let dependencies = Dependencies(
    carthage: [
        .github(path: "AliSoftware/OHHTTPStubs", requirement: .upToNext("9.0.0")),
    ],
    swiftPackageManager: [
        .remote(url: "https://github.com/Alamofire/Alamofire", requirement: .upToNextMajor(from: "5.0.0")),
    ],
    platforms: [.iOS]
)
