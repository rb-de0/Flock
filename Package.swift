import PackageDescription

let package = Package(
    name: "Flock",
    dependencies: [
        .Package(url: "https://github.com/jakeheis/SwiftCLI", majorVersion: 3, minor: 0),
        .Package(url: "https://github.com/onevcat/Rainbow", majorVersion: 2, minor: 0),
        .Package(url: "https://github.com/jakeheis/Spawn", majorVersion: 0, minor: 0),
        .Package(url: "/Users/jakeheiser/Desktop/Projects/Swift/CNMSSH", majorVersion: 0)
    ],
    exclude: [
        "Tests/TestProject"
    ]
)
//swift build -Xlinker -lssh2 -Xlinker -L/usr/local/lib/