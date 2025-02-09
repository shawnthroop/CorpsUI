// swift-tools-version: 6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "CorpsUI",
    platforms: [
        .iOS(.v15),
    ],
    products: [
        .library(name: "CorpsUI", targets: ["CorpsUI"]),
    ],
    dependencies: [
        .package(url: "https://github.com/shawnthroop/CorpsFoundation.git", from: "0.1.0"),
    ],
    targets: [
        .target(
            name: "CorpsUI",
            dependencies: [
                "CorpsFoundation",
            ]
        ),
    ]
)
