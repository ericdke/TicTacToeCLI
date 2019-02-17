// swift-tools-version:5.0
import PackageDescription

let package = Package(
    name: "TicTacToe",
    products: [
        .executable(
            name: "TicTacToe",
            targets: ["TicTacToe"])
    ],
    dependencies: [
    ],
    targets: [
        .target(
            name: "TicTacToe",
            dependencies: [],
            path: "Sources")
    ]
)
