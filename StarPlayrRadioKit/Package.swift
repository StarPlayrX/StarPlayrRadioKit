// swift-tools-version: 5.6
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "StarPlayrRadioKit",
    platforms: [
           .macOS(.v10_12),
           .iOS(.v12)
       ],
    products: [
        .library(
            name: "StarPlayrRadioKit",
            targets: ["StarPlayrRadioKit"]),
    ],
    dependencies: [
        .package(url: "https://github.com/StarPlayrX/Swifter-Lite", branch: "1.5.1")
    ],
    targets: [
        .target(
            name: "StarPlayrRadioKit",
            dependencies: [.product(name: "SwifterLite", package: "Swifter-Lite")]
        ),
    ]
)
