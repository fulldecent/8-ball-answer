// swift-tools-version:5.1

import PackageDescription

let package = Package(
    name: "8 Ball",
    platforms: [.iOS(.v9), .watchOS(.v2)],
    products: [
        .library(
            name: "EightBalliOS",
            targets: ["EightBalliOS"]
        ),
        .library(
           name: "EightBallWatchKit",
           targets: ["EightBallWatchKit"]
        )
    ],
    dependencies: [],
    targets: [
        .target(
            name: "EightBalliOS",
            dependencies: []
        ),
        .target(
            name: "EightBallWatchKit",
            dependencies: []
        ),
        .testTarget(
            name: "EightBalliOSTests",
            dependencies: ["EightBalliOS"]
        )
    ]
)
