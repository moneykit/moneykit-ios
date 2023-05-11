// swift-tools-version:5.5
import PackageDescription

let package = Package(
  name: "MoneyKit",
  platforms: [
    .iOS(.v13),
  ],
  products: [
    .library(
      name: "MoneyKit",
      targets: ["MoneyKit"]
    )
  ],
  targets: [
    .binaryTarget(
      name: "MoneyKit",
      path: "MoneyKit.xcframework"
    )
  ]
)