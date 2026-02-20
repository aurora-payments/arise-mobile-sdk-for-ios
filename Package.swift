// swift-tools-version: 6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "ARISEMobileSDK",
    platforms: [
        .iOS(.v18)
    ],
    products: [
        .library(
            name: "ARISEMobileSDK",
            targets: ["ARISEMobileSDK"]
        ),
    ],
    dependencies: [
        // Required for ARISE.xcframework
        .package(url: "https://github.com/apple/swift-openapi-runtime.git", from: "1.0.0"),
        .package(url: "https://github.com/apple/swift-openapi-urlsession.git", from: "1.0.0"),
        .package(url: "https://github.com/apple/swift-http-types.git", from: "1.0.0"),
        // Required for CloudCommerce.xcframework
        // Pinned to exact version for supply chain security (third-party crypto library)
        .package(url: "https://github.com/krzyzanowskim/CryptoSwift.git", exact: "1.8.4"),
        .package(url: "https://github.com/apple/swift-asn1.git", from: "1.2.0"),
        .package(url: "https://github.com/apple/swift-certificates.git", from: "1.0.0"),
    ],
    targets: [
        .binaryTarget(
            name: "ARISE",
            url: "https://github.com/aurora-payments/arise-mobile-sdk-for-ios/releases/download/v0.0.7/ARISE.xcframework.zip",
            checksum: "9723c47301ec28606a4b6f82375a4f09c4565d0935aec3e0bdf11f915909ed78"
        ),
        .binaryTarget(
            name: "CloudCommerce",
            url: "https://github.com/aurora-payments/arise-mobile-sdk-for-ios/releases/download/v0.0.7/CloudCommerce.xcframework.zip",
            checksum: "fbc545e4a70f0d30bf314b7218a79cddf8b46fa25380c67948f480cb635ae49e"
        ),
        .target(
            name: "ARISEMobileSDK",
            dependencies: [
                "ARISE",
                "CloudCommerce",
                .product(name: "OpenAPIRuntime", package: "swift-openapi-runtime"),
                .product(name: "OpenAPIURLSession", package: "swift-openapi-urlsession"),
                .product(name: "HTTPTypes", package: "swift-http-types"),
                .product(name: "CryptoSwift", package: "CryptoSwift"),
                .product(name: "SwiftASN1", package: "swift-asn1"),
                .product(name: "X509", package: "swift-certificates"),
            ],
            path: "Sources/ARISEMobileSDK"
        ),
    ]
)
