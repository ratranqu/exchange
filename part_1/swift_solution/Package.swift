// swift-tools-version:5.9

import PackageDescription

let package = Package(
    name: "Exchange",
    targets:
    [
        .target(name: "Exchange", dependencies: ["ExchangeLib"],
            swiftSettings: [
                .unsafeFlags(["-static-stdlib"], .when(platforms: [.linux])),
            ],
            linkerSettings: [
                .unsafeFlags(["-static-stdlib"], .when(platforms: [.linux])),
            ]),
        .target(name: "ExchangeLib")
    ]
)
