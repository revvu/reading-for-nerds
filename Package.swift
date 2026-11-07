// swift-tools-version: 6.2
import PackageDescription

let package = Package(
    name: "ReadingForNerds",
    platforms: [.macOS(.v14)],
    targets: [
        .target(name: "ReaderCore"),
        .executableTarget(name: "ReadingForNerds", dependencies: ["ReaderCore"]),
        .testTarget(name: "ReaderCoreTests", dependencies: ["ReaderCore"]),
    ]
)
