// swift-tools-version:5.5
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "CoreInsights",
    platforms: [
        .watchOS(.v7)
    ],
    products: [
        .library(
            name: "CoreTracking",
            targets: ["CoreTracking"]),
        .library(
            name: "CoreAnalytics",
            targets: ["CoreAnalytics"])
    ],
    dependencies: [
    ],
    targets: [
        .target(
            name: "CoreTracking",
            dependencies: ["CoreInsightsShared"],
            path: "Sources/CoreTracking"),
        .target(
            name: "CoreAnalytics",
            dependencies: ["CoreInsightsShared"],
            path: "Sources/CoreAnalytics"),
        .target(
            name: "CoreInsightsShared",
            dependencies: [],
            path: "Sources/Shared")
    ]
)
