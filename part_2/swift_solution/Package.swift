// swift-tools-version:5.10

import PackageDescription

let package = Package(
    name: "Exchange",
    platforms: [
        .iOS(.v13),
        .macOS(.v10_15),
        .tvOS(.v13),
        .watchOS(.v6),
    ],
    dependencies: [
        .package(url: "https://github.com/pointfreeco/swift-parsing", exact: "0.13.0"),
//        .package(url: "https://github.com/ratranqu/swift-parsing", branch: "main"),
        .package(url: "https://github.com/apple/swift-argument-parser", from: "1.2.0"),
        .package(
            url: "https://github.com/apple/swift-collections.git",
                .upToNextMinor(from: "1.1.0") // or `.upToNextMajor
        )
    ],
    targets: [
        .executableTarget(name: "Exchange", dependencies: ["ExchangeLib",
                                                 .product(name: "Parsing", package: "swift-parsing"),
                                                 .product(name: "ArgumentParser", package: "swift-argument-parser"),
                                                ],
            swiftSettings: [
                .unsafeFlags(["-static-stdlib"], .when(platforms: [.linux])),
            ],
            linkerSettings: [
                .unsafeFlags(["-static-stdlib"], .when(platforms: [.linux])),
            ]
        ),
        .target(name: "ExchangeLib",
                dependencies: [
                    .product(name: "Parsing", package: "swift-parsing"),
                    .product(name: "ArgumentParser", package: "swift-argument-parser"),
                    .product(name: "Collections", package: "swift-collections")
                ]),
        .testTarget(name: "Tests", dependencies: ["ExchangeLib"], path: "Tests")
    ]
)
