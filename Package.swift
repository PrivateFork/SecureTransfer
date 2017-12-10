// swift-tools-version:3.0.2

import PackageDescription

let package = Package(
    name: "CoreSecureTransfer",
    dependencies: [
        .Package(url: "https://github.com/PureSwift/GATT", majorVersion: 1),
        .Package(url: "https://github.com/krzyzanowskim/CryptoSwift", majorVersion: 0, minor: 6),
        .Package(url: "https://github.com/OpenKitten/BSON.git", majorVersion: 5)
    ],
    exclude: ["iOS"]
)
