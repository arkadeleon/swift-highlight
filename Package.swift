// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Highlight",
    platforms: [
        .iOS(.v9)
    ],
    products: [
        .library(
            name: "Highlight",
            targets: ["Highlight"]),
    ],
    targets: [
        .target(
            name: "Highlight",
            path: "Sources/Highlight",
            resources: [
                .copy("Resources/highlightjs")
            ]),
        .testTarget(
            name: "HighlightTests",
            dependencies: ["Highlight"],
            path: "Tests/HighlightTests"),
    ],
    swiftLanguageVersions: [.v5]
)
