import ProjectDescription

let project = Project(
    name: "MenuTaro",
    targets: [
        .target(
            name: "MenuTaro",

            destinations: [.iPhone],

            product: .app,
            bundleId: "fd2.tuist.MenuTaro",

            deploymentTargets: .iOS("17.6"),

            infoPlist: .extendingDefault(with: [
                "CFBundleShortVersionString": "1.0.1",
                "CFBundleVersion": "2",

                "UIDeviceFamily": [1],

                "CFBundleDevelopmentRegion": "ko",
                "CFBundleLocalizations": ["ko"],

                "CFBundleDisplayName": "뭐 먹을끼니?",
                "UILaunchScreen": [
                    "UIColorName": "",
                    "UIImageName": "",
                ],
            ]),

            sources: ["MenuTaro/Sources/**"],
            resources: ["MenuTaro/Resources/**"],
            dependencies: [],

            settings: .settings(
                base: [
                    "SUPPORTS_MACCATALYST": "NO",
                    "DERIVE_MACCATALYST_PRODUCT_BUNDLE_IDENTIFIER": "NO",
                ]
            )
        ),

        .target(
            name: "MenuTaroTests",
            destinations: [.iPhone],
            product: .unitTests,
            bundleId: "dev.tuist.MenuTaroTests",
            infoPlist: .default,
            sources: ["MenuTaro/Tests/**"],
            resources: [],
            dependencies: [.target(name: "MenuTaro")]
        ),
    ]
)
