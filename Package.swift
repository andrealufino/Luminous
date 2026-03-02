// swift-tools-version:5.3

import PackageDescription

let package = Package(
    name: "Luminous",
    platforms: [
        .iOS(.v12)
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
            path: "Sources"),
        .testTarget(
            name: "LuminousTests",
            dependencies: ["Luminous"]),
    ]
)
