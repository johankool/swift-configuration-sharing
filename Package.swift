// swift-tools-version: 6.2
import PackageDescription

let package = Package(
    name: "ConfigurationSharing",
    platforms: [
        .iOS(.v18),
        .macOS(.v15),
        .tvOS(.v18),
        .watchOS(.v11),
        .visionOS(.v2)
    ],
    products: [
        .library(
            name: "ConfigurationSharing",
            targets: ["ConfigurationSharing"]
        )
    ],
    dependencies: [
        .package(url: "https://github.com/apple/swift-configuration.git", from: "1.0.0"),
        .package(url: "https://github.com/pointfreeco/swift-dependencies", from: "1.0.0"),
        .package(url: "https://github.com/pointfreeco/swift-sharing", from: "2.7.4"),
        .package(url: "https://github.com/swift-server/swift-service-lifecycle", from: "2.7.0"),
        .package(url: "https://github.com/apple/swift-log", from: "1.6.3")
    ],
    targets: [
        .target(
            name: "ConfigurationSharing",
            dependencies: [
                .product(name: "Configuration", package: "swift-configuration"),
                .product(name: "Dependencies", package: "swift-dependencies"),
                .product(name: "Sharing", package: "swift-sharing"),
                .product(name: "ServiceLifecycle", package: "swift-service-lifecycle"),
                .product(name: "Logging", package: "swift-log")
            ],
            swiftSettings: [
                // Workaround for Swift 6.2 Linux linking: Observation depends on Threading
                .unsafeFlags(["-Xlinker", "-rpath", "-Xlinker", "/usr/lib/swift/linux"], .when(platforms: [.linux]))
            ]
        ),
        .testTarget(
            name: "ConfigurationSharingTests",
            dependencies: [
                "ConfigurationSharing",
                .product(name: "Dependencies", package: "swift-dependencies")
            ],
            swiftSettings: [
                // Workaround for Swift 6.2 Linux linking: Observation depends on Threading
                .unsafeFlags(["-Xlinker", "-rpath", "-Xlinker", "/usr/lib/swift/linux"], .when(platforms: [.linux]))
            ]
        )
    ]
)
