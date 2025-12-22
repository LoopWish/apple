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
        .library(name: "LoopwishResources", targets: ["LoopwishResources"]),
        .executable(name: "LoopwishApp", targets: ["LoopwishApp"])
    ],
    targets: [
        .target(
            name: "LoopwishCore",
            path: "Loopwish/Core"
        ),
        .target(
            name: "LoopwishResources",
            path: ".",
            exclude: [
                ".loopwish",
                "CODE_OF_CONDUCT.md",
                "CONTRIBUTING.md",
                "LICENSE",
                "README.md",
                "scripts",
                "Loopwish/App",
                "Loopwish/Core",
                "Loopwish/Tests"
            ],
            sources: [
                "Loopwish/Resources"
            ],
            resources: [
                .process("vendor/shared/design-tokens/tokens.json"),
                .process("vendor/shared/assets/logos")
            ]
        ),
        .executableTarget(
            name: "LoopwishApp",
            dependencies: ["LoopwishCore", "LoopwishResources"],
            path: "Loopwish/App"
        ),
        .testTarget(
            name: "LoopwishTests",
            dependencies: ["LoopwishCore", "LoopwishResources"],
            path: "Loopwish/Tests"
        )
    ]
)
