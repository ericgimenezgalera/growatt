//
//  Dependencies.swift
//  Config
//
//  Created by Eric Gimenez on 13/6/22.
//

import ProjectDescription

let dependencies = Dependencies(
    swiftPackageManager: [
        .remote(url: "https://github.com/Alamofire/Alamofire", requirement: .upToNextMajor(from: "5.0.0")),
        .remote(url: "https://github.com/WeTransfer/Mocker.git", requirement: .upToNextMajor(from: "3.0.0"))
    ],
    platforms: [.iOS]
)
