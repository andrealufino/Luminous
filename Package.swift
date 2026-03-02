// swift-tools-version: 6.0

import PackageDescription

let package = Package(
    name: "Luminous",
    platforms: [
        .iOS(.v17)
    ],
    products: [
        .library(
            name: "Luminous",
            targets: ["Luminous"]),
    ],
    dependencies: [],
    targets: [
        .target(
            name: "Luminous",
            dependencies: [],
            path: "Sources",
            swiftSettings: [
                .swiftLanguageMode(.v6)
            ]
        ),
        .testTarget(
            name: "LuminousTests",
            dependencies: ["Luminous"]
        ),
    ]
)
