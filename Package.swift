// swift-tools-version: 5.9
import PackageDescription

let package = Package(
    name: "Loopwish",
    platforms: [
        .iOS(.v16),
        .macOS(.v13)
    ],
    products: [
        .library(name: "LoopwishCore", targets: ["LoopwishCore"]),
        .executable(name: "LoopwishApp", targets: ["LoopwishApp"])
    ],
    targets: [
        .target(
            name: "LoopwishCore",
            path: "Loopwish/Core"
        ),
        .executableTarget(
            name: "LoopwishApp",
            dependencies: ["LoopwishCore"],
            path: "Loopwish/App"
        ),
        .testTarget(
            name: "LoopwishTests",
            dependencies: ["LoopwishCore"],
            path: "Loopwish/Tests"
        )
    ]
)
