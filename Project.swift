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
let viewInspector = "ViewInspector"
let snapshotTesting = "SnapshotTesting"

let api = Project.makeFrameworkTargets(
    name: apiName,
    destinations: .iOS,
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
    destinations: .iOS,
    dependencies: [
        .target(name: apiName),
        .target(name: diName),
        .external(name: multiProgressView)
    ],
    testDependencies: [
        .external(name: snapshotTesting),
        .external(name: viewInspector)
    ]
)


let diFramework = Project.makeFrameworkTargets(
    name: diName,
    destinations: .iOS,
    dependencies: [],
    testDependencies: []
)

let keyChainWrapper = Project.makeFrameworkTargets(
    name: keyChainWrapperName,
    destinations: .iOS,
    dependencies: [
        .target(name: diName)
    ],
    testDependencies: []
)

// Creates our project using a helper function defined in ProjectDescriptionHelpers
let project = Project.app(
    name: "Growatt",
    destinations: .iOS,
    additionalTargets: api + uiFramework + diFramework + keyChainWrapper
)
