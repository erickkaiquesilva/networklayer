// swift-tools-version:5.10
import PackageDescription

let package = Package(
    name: "networklayer",
    products: [
        .library(
            name: "networklayer",
            targets: ["networklayer"]),
    ],
    targets: [
        .target(
            name: "networklayer",
            path: "Sources/networklayer")
    ]
)
