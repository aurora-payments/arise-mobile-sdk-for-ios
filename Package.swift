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
            url: "https://github.com/aurora-payments/arise-mobile-sdk-for-ios/releases/download/v0.0.7-pre-release-3/ARISE.xcframework.zip",
            checksum: "6bb562ddc69da22be7a33d008376f149b8148cc2c37c8232e487eaa8d4a5d966"
        ),
        .binaryTarget(
            name: "CloudCommerce",
            url: "https://github.com/aurora-payments/arise-mobile-sdk-for-ios/releases/download/v0.0.7-pre-release-3/CloudCommerce.xcframework.zip",
            checksum: "e141ef277a0fc0c8b015a2ad5844f97fcbb1b428ed00eb5d69dd61be8f78a8be"
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
