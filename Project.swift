import ProjectDescription
import ProjectDescriptionHelpers

// MARK: - Project

// Internal targets
let apiName = "API"
let uiName = "UserInterface"
let diName = "DependencyInjection"
let keyChainWrapperName = "KeychainWrapper"

// External targets
let alamofireName = "Alamofire"
let mockerName = "Mocker"
let multiProgressView = "MultiProgressView"

let api = Project.makeFrameworkTargets(
    name: apiName,
    platform: .iOS,
    dependencies: [
        .target(name: keyChainWrapperName),
        .target(name: diName),
        .external(name: alamofireName)
    ],
    testDependencies: [
        .external(name: mockerName)
    ]
)

let uiFramework = Project.makeFrameworkTargets(
    name: uiName,
    platform: .iOS,
    dependencies: [
        .target(name: apiName),
        .target(name: diName),
        .external(name: multiProgressView)
    ],
    testDependencies: []
)


let diFramework = Project.makeFrameworkTargets(
    name: diName,
    platform: .iOS,
    dependencies: [],
    testDependencies: []
)

let keyChainWrapper = Project.makeFrameworkTargets(
    name: keyChainWrapperName,
    platform: .iOS,
    dependencies: [
        .target(name: diName)
    ],
    testDependencies: []
)

// Creates our project using a helper function defined in ProjectDescriptionHelpers
let project = Project.app(
    name: "Growatt",
    platform: .iOS,
    additionalTargets: api + uiFramework + diFramework + keyChainWrapper
)
