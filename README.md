# 8 Ball Answer 🎱

[![CI](https://github.com/fulldecent/8-ball-answer/actions/workflows/ci.yml/badge.svg?branch=main)](https://github.com/fulldecent/8-ball-answer/actions/workflows/ci.yml)

Get it now on the App Store: [iOS](https://apps.apple.com/us/app/8-ball-answer/id995732766)

A delightfully simple iOS + watchOS app for answering questions, 8 Ball Answer is perfect for providing entertainment and making randomized decisions. Just tap the screen and receive an answer!

**Features:**

- With a single tap, users may receive immediate responses to any question
- Randomized answer presets allow users to make decisions similar to flipping a coin, but with more complex answers
- Minimalistic and readable design allows users to easily see answers with an uncluttered, simple display
- Available on iOS and watchOS so users can ask questions on the go

# Installation ⚙️

To install and enjoy 8 Ball Answer, follow these simple steps:

1. **Download from the App Store**: 8 Ball Answer is available for download on the App Store for iOS & watchOS at this link: <https://apps.apple.com/us/app/8-ball-answer/id995732766>

2. **Launch the app**: Once installed, launch the app by tapping on its icon.

3. **Ask a question**: Tap on the screen to ask a question.

4. **Receive an answer**: After tapping, an answer to your question will appear on the screen.

# Gameplay visuals 📸

**Waiting screen before a question is asked:**
![Simulator Screen Shot - iPad Pro (12 9-inch) (3rd generation) - 2020-01-02 at 15 50 13](https://user-images.githubusercontent.com/382183/71692537-2d721c80-2d78-11ea-8da9-17b4c713647b.png)
**Potential answer to a question:**
![Simulator Screen Shot - iPad Pro (12 9-inch) (3rd generation) - 2020-01-02 at 15 50 14](https://user-images.githubusercontent.com/382183/71692538-2e0ab300-2d78-11ea-95f6-ef786291693f.png)

## Development

Format the Swift files the CI workflow checks. The formatter is `swift format`, the same one the Swift 6 Module Template soundness workflow runs.

```sh
swift format format --in-place --recursive "8 Ball" "8 BallTests"
```

Run the tests on the iPhone 17 simulator:

```sh
xcodebuild test \
  -project "8 Ball.xcodeproj" \
  -scheme "8 Ball" \
  -destination 'platform=iOS Simulator,name=iPhone 17,OS=27.0' \
  CODE_SIGNING_ALLOWED=NO
```

`CODE_SIGNING_ALLOWED=NO` is for a machine that does not have the device provisioning profile. A local run signed with your own team can omit it.

## Setup

This is the maintainer setup for [.github/workflows/release.yml](.github/workflows/release.yml).

1. GitHub repo > Settings > General > Releases > Enable release immutability.
2. GitHub repo > Settings > Actions > General > Workflow permissions: Read and write permissions. Check "Allow GitHub Actions to create and approve pull requests".
3. Sign the Apple Developer Program agreement. App Store Connect API calls fail until it is in effect.
4. Repository secrets:

   | Secret | Value |
   | --- | --- |
   | `APP_STORE_CONNECT_KEY_ID` | App Store Connect API key id |
   | `APP_STORE_CONNECT_ISSUER_ID` | Issuer id |
   | `APP_STORE_CONNECT_KEY` | Contents of the AuthKey `.p8` file |
   | `APP_STORE_DISTRIBUTION_P12` | Base64 of an Apple Distribution PKCS12 |
   | `APP_STORE_DISTRIBUTION_P12_PASSWORD` | Password for that PKCS12 |
   | `APP_STORE_MAC_INSTALLER_P12` | Base64 of a Mac Installer Distribution PKCS12 |
   | `APP_STORE_MAC_INSTALLER_P12_PASSWORD` | Password for that PKCS12 |

   The workflow creates the provisioning profiles at build time. Profiles are not stored. The API key needs App Manager access. Replace a secret with `gh secret set <NAME> --repo fulldecent/8-ball-answer`. For the certificate, `base64 < distribution.p12` is the value of `APP_STORE_DISTRIBUTION_P12`. `fastlane cert` can create a new Apple Distribution certificate when the private key on this machine cannot be exported.

## Releasing a new version

Every push to `main` tests the app, then uploads an iOS build and a macOS build to TestFlight and adds both to the internal group App Store Connect Users. The marketing version comes from [VERSION](VERSION). The build number is one higher than the newest TestFlight build on either platform and is not committed.

Commit messages on `main` use [Conventional Commits 1.0.0](https://www.conventionalcommits.org/en/v1.0.0/). `fix:` bumps the patch version, `feat:` bumps the minor version, and `BREAKING CHANGE:` bumps the major version. `ci:` and `chore:` do not. [Release Please](https://github.com/googleapis/release-please) opens a pull request that updates [VERSION](VERSION), the `MARKETING_VERSION` lines marked `x-release-please-version`, and `CHANGELOG.md`. Merging that pull request runs the screenshot job and then submits the iOS and macOS versions for review with automatic release. The GitHub tag `v<version>` is created after that submission succeeds.

Store text lives in [fastlane/metadata](fastlane/metadata) for iOS and [fastlane/metadata-macos](fastlane/metadata-macos) for macOS. The release uploads those files. A language that has answers in [answers-by-locale.json](answers-by-locale.json) and no metadata folder is uploaded with the `en-US` text so its screenshots have a listing. What's New is the newest section of `CHANGELOG.md`. Screenshots are generated for iPhone, iPad, and Mac during that release and are not committed. watchOS and visionOS are in the Xcode target and are not separate App Store listings.

`fastlane/Fastfile` strips `/opt/homebrew` and `/usr/local` from `PATH` before `xcodebuild -exportArchive`. Xcode's IPA export calls `rsync -E`, and Homebrew's `rsync` rejects that flag ("Copy failed").

The same lanes can be run locally after `bundle install` with Ruby from `.ruby-version` and a gitignored `fastlane/api_key.json` (`key_id`, `issuer_id`, `key_filepath`). The distribution certificate has to be in the keychain.

```sh
bundle exec fastlane ship_testflight
bundle exec fastlane generate_screenshots
bundle exec fastlane submit_app_store build_number:123
```

## References

1. This project is built based on [best practices documented in Swift 6 Module Template](https://github.com/fulldecent/swift6-module-template), release 16.5.0. Continuous integration follows that release's macOS job: the GitHub-hosted `xcode-27` runner and `actions/checkout@v7`. The template runs `xcrun swift test` for a Swift package. This repository is an Xcode app, so [.github/workflows/ci.yml](.github/workflows/ci.yml) runs `xcodebuild test` on the iPhone 17 simulator for iOS 27.0.
2. Releases follow the template's [release workflow](https://github.com/fulldecent/swift6-module-template/blob/v16.5.0/.github/workflows/release.yml), release 16.5.0. That workflow attests a Linux static library. This repository uploads the iOS and macOS apps to TestFlight on every push to `main`, and submits both for App Store review when the release pull request merges. The version file is [VERSION](VERSION).
3. Swift ignore rules follow the template's [.gitignore](https://github.com/fulldecent/swift6-module-template/blob/v16.5.0/.gitignore), which inlines [Swift.gitignore](https://github.com/github/gitignore/blob/main/Swift.gitignore). `fastlane/api_key.json`, `*.p8`, and `vendor/bundle/` stay ignored because those files are secrets or a local Ruby install.
4. The license is MIT. The template says to consider which license applies. This repository had no license file. Copyright starts at the first commit, 2015.
