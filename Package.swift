// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Highlight",
    platforms: [
        .macOS(.v10_13),
        .iOS(.v11),
        .tvOS(.v11),
        .watchOS(.v4),
    ],
    products: [
        .library(
            name: "Highlight",
            targets: ["Highlight"]),
    ],
    targets: [
        .target(
            name: "Highlight",
            resources: [.copy("Resources/highlightjs")]),
        .testTarget(
            name: "HighlightTests",
            dependencies: ["Highlight"]),
    ]
)
