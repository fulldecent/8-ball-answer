# Contributing

All contributors are welcome. Please use issues and pull requests to contribute to the project. Commit messages use `fix:`, `feat:`, or `BREAKING CHANGE:`. Release Please writes [CHANGELOG.md](CHANGELOG.md) from those messages. Confirm the build is [passing in GitHub Actions](https://github.com/fulldecent/8-ball-answer/actions) before merging.

## Release process

Merging the release pull request tags the release and submits that version to the App Store. The settings that pull request needs are in [Releasing a new version](README.md#releasing-a-new-version). Confirm the build is [passing in GitHub Actions](https://github.com/fulldecent/8-ball-answer/actions) before merging it.

## Development

The commands CI runs are in [Development](README.md#development).

## Maintenance

Do this every quarter or so.

1. Review the runner in [.github/workflows/ci.yml](.github/workflows/ci.yml). The job uses the GitHub-hosted `xcode-27` image because that is the image in [Swift 6 Module Template 16.5.0](https://github.com/fulldecent/swift6-module-template/blob/v16.5.0/.github/workflows/swiftlang-workflows.yml). The test destination is an iPhone 17 simulator on iOS 27.0, which that image lists for Xcode 27.0. `xcrun swift test` builds a Swift package, and this repository is an Xcode app, so the workflow uses `xcodebuild` instead. The image contents are in the [Xcode 27 runner readme](https://github.com/actions/runner-images/blob/main/images/macos/xcode-27-arm64-Readme.md).
2. Review external actions in [.github/workflows](.github/workflows). The workflows currently use `actions/checkout@v7`, `googleapis/release-please-action@v5`, and `ruby/setup-ruby@v1`. The publish job runs on `xcode-27` because it archives the iOS app.
