// swift-tools-version: 5.7
import PackageDescription

let package = Package(
    name: "HugoBlinkyApp",
    platforms: [.iOS(.v14)],
    products: [
        .library(name: "HugoBlinkyApp", targets: ["HugoBlinkyApp"]),
    ],
    targets: [
        .target(name: "HugoBlinkyApp", path: "HugoBlinkyApp"),
    ]
)
