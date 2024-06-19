// swift-tools-version: 5.10

import PackageDescription

let package = Package(
    name: "SuggestionTextField",
    platforms: [.macOS(.v14)],
    products: [
        .library(
            name: "SuggestionTextField",
            targets: ["SuggestionTextField"]
        ),
    ],
    targets: [
        .target(name: "SuggestionTextField"),
    ]
)
