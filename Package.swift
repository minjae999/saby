// swift-tools-version: 5.6
import PackageDescription

let package = Package(
    name: "Saby",
    products: [
        .library(
            name: "SabyConcurrency",
            targets: ["SabyConcurrency"]),
        .library(
            name: "SabyExpect",
            targets: ["SabyExpect"]),
        .library(
            name: "SabyJSON",
            targets: ["SabyJSON"]),
        .library(
            name: "SabyMock",
            targets: ["SabyMock"]),
        .library(
            name: "SabyNetwork",
            targets: ["SabyNetwork"]),
        .library(
            name: "SabySafe",
            targets: ["SabySafe"]),
        .library(
            name: "SabyTime",
            targets: ["SabyTime"]),
    ],
    dependencies: [
    ],
    targets: [
        .target(
            name: "SabyConcurrency",
            dependencies: [],
            path: "Source/Concurrency"),
        .target(
            name: "SabyExpect",
            dependencies: ["SabyConcurrency"],
            path: "Source/Expect"),
        .target(
            name: "SabyJSON",
            dependencies: [],
            path: "Source/JSON"),
        .target(
            name: "SabyMock",
            dependencies: ["SabyJSON"],
            path: "Source/Mock"),
        .target(
            name: "SabyNetwork",
            dependencies: ["SabyConcurrency", "SabyJSON", "SabySafe"],
            path: "Source/Network"),
        .target(
            name: "SabySafe",
            dependencies: [],
            path: "Source/Safe"),
        .target(
            name: "SabyTime",
            dependencies: [],
            path: "Source/Time"),
        .testTarget(
            name: "SabyConcurrencyTest",
            dependencies: ["SabyConcurrency"],
            path: "Test/Concurrency"),
        .testTarget(
            name: "SabyJSONTest",
            dependencies: ["SabyJSON"],
            path: "Test/JSON"),
        .testTarget(
            name: "SabyNetworkTest",
            dependencies: ["SabyNetwork", "SabyMock", "SabyExpect"],
            path: "Test/Network"),
        .testTarget(
            name: "SabySafeTest",
            dependencies: ["SabySafe"],
            path: "Test/Safe"),
        .testTarget(
            name: "SabyTimeTest",
            dependencies: ["SabyTime"],
            path: "Test/Time"),
    ]
)
