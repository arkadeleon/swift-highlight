// swift-tools-version: 6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "swift-highlight",
    platforms: [
        .macOS(.v10_14),
        .iOS(.v12),
        .tvOS(.v12),
        .watchOS(.v5),
        .visionOS(.v1),
    ],
    products: [
        .library(
            name: "Highlight",
            targets: ["Highlight"]),
    ],
    targets: [
        .target(
            name: "Highlight",
            resources: [
                .copy("Resources/highlightjs"),
                .copy("Resources/highlightjs-line-numbers"),
            ]),
        .testTarget(
            name: "HighlightTests",
            dependencies: ["Highlight"]),
    ]
)
