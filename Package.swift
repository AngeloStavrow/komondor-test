// swift-tools-version:4.2

import PackageDescription

let package = Package(
    name: "[komondor-test]",
    dependencies: [
        .package(url: "https://github.com/shibapm/Komondor.git", from: "1.0.4")
    ],
    targets: [
        .target(name: "komondor-test", dependencies: [], path: "komondor-test", sources: ["Dummyfile.swift"]),
    ]
)

#if canImport(PackageConfig)
    import PackageConfig

    let config = PackageConfiguration([
        "komondor": [
            "pre-commit": "echo 'Hi'"
        ],
    ]).write()
#endif
