// swift-tools-version:5.5
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "APSwift",
    platforms: [
        .iOS(.v12)
        ],
    products: [
        // Products define the executables and libraries a package produces, and make them visible to other packages.
        .library(
            name: "APSwift",
            targets: ["APSwift"]),
    ],
    dependencies: [
        // Dependencies declare other packages that this package depends on.
        .package(url: "https://github.com/SnapKit/SnapKit.git", .upToNextMajor(from: "5.0.1")),
        .package(url: "https://github.com/onevcat/Kingfisher.git", .upToNextMajor(from: "7.0.0")),
//        .package(url: "https://github.com/Alamofire/Alamofire.git", .upToNextMajor(from: "5.5.0")),
        .package(url: "https://github.com/evgenyneu/keychain-swift.git", .upToNextMajor(from: "20.0.0"))
        
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages this package depends on.
        .target(
            name: "APSwift",
            dependencies: [
                "SnapKit",
                "Kingfisher",
//                "Alamofire",
                .product(name: "KeychainSwift", package: "keychain-swift")
            ]),
        .testTarget(
            name: "APSwiftTests",
            dependencies: ["APSwift"]),
    ]
)
