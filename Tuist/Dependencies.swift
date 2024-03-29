//
//  Dependencies.swift
//  Config
//
//  Created by Eric Gimenez on 13/6/22.
//

import ProjectDescription

let dependencies = Dependencies(
    swiftPackageManager: .init([
        .remote(url: "https://github.com/Alamofire/Alamofire", requirement: .upToNextMajor(from: "5.0.0")),
        .remote(url: "https://github.com/WeTransfer/Mocker.git", requirement: .upToNextMajor(from: "3.0.0")),
        .remote(url: "https://github.com/mac-gallagher/MultiProgressView.git", requirement: .upToNextMajor(from: "1.2.0")),
        .remote(url: "https://github.com/nalexn/ViewInspector.git", requirement: .upToNextMajor(from: "0.9.8"))
    ]),
    platforms: [.iOS]
)
