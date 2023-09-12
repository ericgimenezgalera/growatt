import ProjectDescription
import ProjectDescriptionHelpers

// MARK: - Project


let api = Project.makeFrameworkTargets(
    name: "API",
    platform: .iOS,
    dependencies: [
        .external(name: "Alamofire"),
        .external(name: "Mocker")
    ],
    testDependencies: [ ]
)

let uiFramework = Project.makeFrameworkTargets(
    name: "UIFramework",
    platform: .iOS,
    dependencies: [
        .target(name: "API")
    ],
    testDependencies: []
)

// Creates our project using a helper function defined in ProjectDescriptionHelpers
let project = Project.app(name: "Growatt",
                          platform: .iOS,
                          additionalTargets: api + uiFramework)
