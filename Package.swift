// swift-tools-version:5.0

import PackageDescription

let package = Package(
    name: "[komondor-test]",
    dependencies: [
        .package(url: "https://github.com/shibapm/Komondor.git", from: "1.0.4"),
        .package(url: "https://github.com/realm/SwiftLint.git", from: "0.33.0"),
    ],
    targets: [
        .target(name: "komondor-test", dependencies: [], path: "komondor-test", sources: ["Dummyfile.swift"]),
    ]
)

#if canImport(PackageConfig)
    import PackageConfig

    let config = PackageConfiguration([
        "komondor": [
            "pre-commit": [
                "echo '[🤖 Starting pre-commit tasks]'",
                "echo '[🤖 Running SwiftLint]'",
                "swift run swiftlint autocorrect --path komondor-test/",
                "echo '[🤖 Adding changes to commit]'",
                "xcrun agvtool next-version -all",
                "echo '[🤖 Pre-commit tasks complete]'",
            ]
        ],
    ]).write()
#endif
