// swift-tools-version:5.10
import PackageDescription

let package = Package(
    name: "NetworkLayer",
    platforms: [
        .iOS(.v13),
        .macOS(.v10_15)
    ],
    products: [
        .library(
            name: "NetworkLayer",
            targets: ["NetworkLayer"]),
    ],
    targets: [
        .target(
            name: "NetworkLayer",
            path: "Sources"),
        .testTarget(
            name: "NetworkLayerTests",
            dependencies: ["NetworkLayer"]
        )
    ]
)
