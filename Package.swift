// swift-tools-version:5.5
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "CoreInsights",
    products: [
        .library(
            name: "CoreInsights",
            targets: ["CoreInsights"]),
    ],
    dependencies: [
    ],
    targets: [
        .target(
            name: "CoreInsights",
            dependencies: []),
    ]
)
