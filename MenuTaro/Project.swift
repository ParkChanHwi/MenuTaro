import ProjectDescription

let project = Project(
    name: "MenuTaro",
    targets: [
        .target(
            name: "MenuTaro",
            destinations: .iOS,
            product: .app,
            bundleId: "dev.tuist.MenuTaro",
            infoPlist: .extendingDefault(
                with: [
                    "UILaunchScreen": [
                        "UIColorName": "",
                        "UIImageName": "",
                    ],
                ]
            ),
            sources: ["MenuTaro/Sources/**"],
            resources: ["MenuTaro/Resources/**"],
            dependencies: [
                .external(name: "Lottie")
            ]
        ),
        .target(
            name: "MenuTaroTests",
            destinations: .iOS,
            product: .unitTests,
            bundleId: "dev.tuist.MenuTaroTests",
            infoPlist: .default,
            sources: ["MenuTaro/Tests/**"],
            resources: [],
            dependencies: [.target(name: "MenuTaro")]
        ),
    ]
)
