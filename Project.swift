import ProjectDescription
import ProjectDescriptionHelpers

// MARK: - Project


let api = Project.makeFrameworkTargets(
    name: "API",
    platform: .iOS,
    dependencies: [
        .target(name: "KeyChainWrapper"),
        .external(name: "Alamofire")
    ],
    testDependencies: [
        .external(name: "Mocker")
    ]
)

let uiFramework = Project.makeFrameworkTargets(
    name: "UIFramework",
    platform: .iOS,
    dependencies: [
        .target(name: "API"),
        .target(name: "DIFramework")
    ],
    testDependencies: []
)


let diFramework = Project.makeFrameworkTargets(
    name: "DIFramework",
    platform: .iOS,
    dependencies: [],
    testDependencies: []
)

let keyChainWrapper = Project.makeFrameworkTargets(
    name: "KeyChainWrapper",
    platform: .iOS,
    dependencies: [],
    testDependencies: []
)

// Creates our project using a helper function defined in ProjectDescriptionHelpers
let project = Project.app(
    name: "Growatt",
    platform: .iOS,
    additionalTargets: api + uiFramework + diFramework + keyChainWrapper
)
