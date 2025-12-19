// swift-tools-version: 5.9
import PackageDescription

let package = Package(
    name: "MyApp",
    platforms: [
        .iOS(.v16)
    ],
    products: [
        .library(
            name: "MyApp",
            targets: ["MyApp"]
        )
    ],
    dependencies: [
        // Add your dependencies here
        // Example: .package(url: "https://github.com/realm/realm-swift.git", from: "10.45.0")
    ],
    targets: [
        .target(
            name: "MyApp",
            dependencies: [],
            path: "Sources"
        ),
        .testTarget(
            name: "MyAppTests",
            dependencies: ["MyApp"],
            path: "Tests"
        )
    ]
)
