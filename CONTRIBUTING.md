# Contributing

All contributors are welcome. Please use issues and pull requests to contribute to the project. Confirm the build is [passing in GitHub Actions](https://github.com/fulldecent/8-ball-answer/actions) before merging.

## Release process

This is an App Store app. Releases ship with fastlane, documented in [Releasing a new version](README.md#releasing-a-new-version). Swift 6 Module Template publishes a GitHub Release from Release Please. There is no Linux library to publish here, and the version that ships is `MARKETING_VERSION` in the Xcode project.

## Development

The commands CI runs are in [Development](README.md#development).

## Maintenance

Do this every quarter or so.

1. Review the runner in [.github/workflows/ci.yml](.github/workflows/ci.yml). The job uses the GitHub-hosted `xcode-27` image because that is the image in [Swift 6 Module Template 16.5.0](https://github.com/fulldecent/swift6-module-template/blob/v16.5.0/.github/workflows/swiftlang-workflows.yml). The test destination is an iPhone 17 simulator on iOS 27.0, which that image lists for Xcode 27.0. `xcrun swift test` builds a Swift package, and this repository is an Xcode app, so the workflow uses `xcodebuild` instead. The image contents are in the [Xcode 27 runner readme](https://github.com/actions/runner-images/blob/main/images/macos/xcode-27-arm64-Readme.md).
2. Review external actions in [.github/workflows](.github/workflows). The workflow currently uses `actions/checkout@v7`.
