// swift-tools-version: 5.9
import PackageDescription

#if TUIST
@preconcurrency import ProjectDescription
    import ProjectDescriptionHelpers

    let packageSettings = PackageSettings(
        productTypes: [
            "Alamofire": .framework,
            "Mocker": .framework,
            "MultiProgressView": .framework,
            "ViewInspector": .framework
        ]
    )

#endif

@MainActor let package = Package(
    name: "PackageName",
    dependencies: [
        .package(url: "https://github.com/Alamofire/Alamofire", from: "5.9.1"),
        .package(url: "https://github.com/WeTransfer/Mocker", from: "3.0.0"),
        .package(url: "https://github.com/mac-gallagher/MultiProgressView", from: "1.2.0"),
        .package(url: "https://github.com/nalexn/ViewInspector", from: "0.9.8"),
    ]
)
