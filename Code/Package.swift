// swift-tools-version:5.10
import PackageDescription

let package = Package(
    name: "NetworkLayer",
    products: [
        .library(
            name: "NetworkLayer",
            targets: ["NetworkLayer"]),
    ],
    targets: [
        .target(
            name: "NetworkLayer",
            path: "Sources/NetworkLayer")
    ]
)
