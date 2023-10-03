import ProjectDescription

/// Project helpers are functions that simplify the way you define your project.
/// Share code to create targets, settings, dependencies,
/// Create your own conventions, e.g: a func that makes sure all shared targets are "static frameworks"
/// See https://docs.tuist.io/guides/helpers/

extension Project {
    private static let swiftlintScript = """
    export PATH="$PATH:/opt/homebrew/bin"
    swiftlint lint $SRCROOT/Targets --strict --config ".swiftlint.yml"
    """

    private static let swiftFormatScript = """
    export PATH="$PATH:/opt/homebrew/bin"
    swiftformat $SRCROOT/Targets --config $SRCROOT"/.swiftformat" --quiet
    """

    /// Helper function to create the Project for this ExampleApp
    public static func app(name: String, platform: Platform, additionalTargets: [Target]) -> Project {
        var targets = makeAppTargets(
            name: name,
            platform: platform,
            dependencies: additionalTargets.filter({!$0.bundleId.contains("Test") }).map { TargetDependency.target(name: $0.name) }
        )
        targets += additionalTargets
        return Project(
            name: name,
            organizationName: "eric.gimenez.galera",
            targets: targets
        )
    }

    // MARK: - Private

    /// Helper function to create a framework target and an associated unit test target
    public static func makeFrameworkTargets(name: String, platform: Platform, dependencies: [TargetDependency], testDependencies: [TargetDependency]) -> [Target] {
        var testDependencies = testDependencies
        let sources = Target(name: name,
                platform: platform,
                product: .framework,
                bundleId: "eric.gimenez.galera.\(name)",
                infoPlist: .default,
                sources: ["Targets/\(name)/Sources/**"],
                resources: [],
                scripts: getCommonPreScripts(name),
                dependencies: dependencies)
        testDependencies.append(TargetDependency.target(name: name))
        
        let tests = Target(name: "\(name)Tests",
                platform: platform,
                product: .unitTests,
                bundleId: "eric.gimenez.galera.\(name)Tests",
                infoPlist: .default,
                sources: ["Targets/\(name)/Tests/**"],
                resources: [],
                scripts: getCommonPreScripts(name),
                dependencies: testDependencies)
        return [sources, tests]
    }

    /// Helper function to create the application target and the unit test target.
    private static func makeAppTargets(name: String, platform: Platform, dependencies: [TargetDependency]) -> [Target] {
        let platform: Platform = platform
        let infoPlist: [String: InfoPlist.Value] = [
            "CFBundleShortVersionString": "1.0",
            "CFBundleVersion": "1",
            "UIMainStoryboardFile": "",
            "UILaunchStoryboardName": "LaunchScreen",
            "NSFaceIDUsageDescription": "Use Face ID instead of a password to access your account."
            ]

        let mainTarget = Target(
            name: name,
            platform: platform,
            product: .app,
            bundleId: "eric.gimenez.galera.\(name)",
            infoPlist: .extendingDefault(with: infoPlist),
            sources: ["Targets/\(name)/Sources/**"],
            resources: ["Targets/\(name)/Resources/**"],
            scripts: getCommonPreScripts(name),
            dependencies: dependencies
        )

        let testTarget = Target(
            name: "\(name)Tests",
            platform: platform,
            product: .unitTests,
            bundleId: "eric.gimenez.galera.\(name)Tests",
            infoPlist: .default,
            sources: ["Targets/\(name)/Tests/**"],
            scripts: getCommonPreScripts(name),
            dependencies: [
                .target(name: "\(name)")
        ])
        return [mainTarget, testTarget]
    }
    
    private static func getCommonPreScripts(_ targetName: String) -> [TargetScript] {
        [
            .pre(script: swiftFormatScript, name: "Swift format", outputPaths: ["$(DERIVED_FILE_DIR)/\(targetName)SwiftformatOutput"]),
            .pre(script: swiftlintScript, name: "Swiftlint", outputPaths: ["$(DERIVED_FILE_DIR)/\(targetName)SwiftlintOutput"])
        ]
    }
}
