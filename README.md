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

## Releasing a new version

Merging the release pull request publishes that version to the App Store.

Commit messages on `main` use [Conventional Commits 1.0.0](https://www.conventionalcommits.org/en/v1.0.0/). `fix:` bumps the patch version, `feat:` bumps the minor version, and `BREAKING CHANGE:` bumps the major version. [Release Please](https://github.com/googleapis/release-please) opens a pull request that updates [VERSION](VERSION), the `MARKETING_VERSION` lines marked `x-release-please-version`, and `CHANGELOG.md`. Merging that pull request runs [.github/workflows/release.yml](.github/workflows/release.yml). The workflow tests the app, uploads an iOS build, submits it for review with automatic release, and tags `v<version>`.

The workflow needs the repository secrets and the Apple Developer Program agreement described at the top of [.github/workflows/release.yml](.github/workflows/release.yml). macOS still ships with the local `mac` lanes below. The App Store job publishes the iOS app.

The same upload can be run locally after `bundle install` and `fastlane/api_key.json` exist:

```sh
bundle exec fastlane ios publish_app_store
```

### Local fastlane lanes

The release process uses [fastlane](https://fastlane.tools).

One-time setup:

1. Install Ruby via rbenv (macOS system Ruby is too old for fastlane):

   ```sh
   brew install rbenv ruby-build
   rbenv init # follow the printed shell setup instructions, then restart your shell
   rbenv install   # installs the version from .ruby-version
   bundle install
   ```

2. Create `fastlane/api_key.json` with your App Store Connect API key details:

   ```json
   {
     "key_id": "ABCD123456",
     "issuer_id": "00000000-0000-0000-0000-000000000000",
     "key_filepath": "/absolute/path/to/AuthKey_ABCD123456.p8"
   }
   ```

The pipeline has five stages.

```mermaid
flowchart LR
  bump_version --> b["beta (TestFlight)"] --> screenshots --> upload_screenshots  --> r["release (App Store)"]
```

Execute the end-to-end flow with the combined command:

```sh
bundle exec fastlane ios full_release notes:"Maintenance update"
bundle exec fastlane mac full_release notes:"Maintenance update"
```

Or run individual stages:

1. Bump the marketing version (`MARKETING_VERSION`) and build number:

   ```sh
   bundle exec fastlane bump_version           # patch (default): 1.5 -> 1.5.1
   bundle exec fastlane bump_version bump:minor
   bundle exec fastlane bump_version bump:major
   ```

2. Build, sign, and ship to TestFlight for both iOS and macOS. Each `beta` lane bumps the build number, archives, exports, and uploads via `xcrun altool`:

   ```sh
   bundle exec fastlane ios beta
   bundle exec fastlane mac beta
   ```

   `ios beta` produces `build/8 Ball.ipa`, `mac beta` produces `build/8 Ball.pkg`. Both upload to the same App Store Connect record so the iOS build appears under the iOS TestFlight tab and the macOS build under the macOS TestFlight tab.

   :information_source: The iOS and macOS `beta` lanes upload via `xcrun altool` directly because fastlane's `upload_to_testflight` action currently fails for this app with a stale `previousBundleVersion` mismatch from Apple's ContentDelivery service. The legacy `upload_to_testflight` route is kept as `ios beta_pilot` so it can be re-enabled once Apple resolves the upstream issue.

3. Capture screenshots when needed. The iOS lane supports quick testing of one locale or one device:

   ```sh
   bundle exec fastlane ios screenshots
   bundle exec fastlane ios screenshots locales:en-US devices:"iPhone 17 Pro Max"
   ```

   This writes screenshots to `fastlane/screenshots/`.

4. Upload screenshots separately from submission:

   ```sh
   bundle exec fastlane ios upload_screenshots
   bundle exec fastlane mac upload_screenshots
   ```

5. Submit to the App Store. The `release` lanes are submit-only and do not capture or upload screenshots:

   ```sh
   bundle exec fastlane ios release notes:"Maintenance update"
   bundle exec fastlane mac release notes:"Maintenance update"
   ```

:information_source: If App Store Connect rejects a beta upload because the build number is behind the remote value, set the project build number once to remote highest + 1, commit that change, and then resume normal local increments.

:information_source: Our `before_all` hook in `fastlane/Fastfile` strips `/opt/homebrew` and `/usr/local` from `PATH` before `xcodebuild -exportArchive` runs. This is a workaround for a bug in Xcode 26's IPA packaging step ("Copy failed") because `/usr/bin/rsync` and Homebrew's `rsync` disagree on the `-E` flag.

## References

1. This project is built based on [best practices documented in Swift 6 Module Template](https://github.com/fulldecent/swift6-module-template), release 16.5.0. Continuous integration follows that release's macOS job: the GitHub-hosted `xcode-27` runner and `actions/checkout@v7`. The template runs `xcrun swift test` for a Swift package. This repository is an Xcode app, so [.github/workflows/ci.yml](.github/workflows/ci.yml) runs `xcodebuild test` on the iPhone 17 simulator for iOS 27.0.
2. Releases follow the template's [release workflow](https://github.com/fulldecent/swift6-module-template/blob/v16.5.0/.github/workflows/release.yml), release 16.5.0. That workflow attests a Linux static library. This repository publishes the iOS app with `bundle exec fastlane ios publish_app_store` after the release pull request merges. The version file is [VERSION](VERSION).
3. Swift ignore rules follow the template's [.gitignore](https://github.com/fulldecent/swift6-module-template/blob/v16.5.0/.gitignore), which inlines [Swift.gitignore](https://github.com/github/gitignore/blob/main/Swift.gitignore). `fastlane/api_key.json`, `*.p8`, and `vendor/bundle/` stay ignored because those files are secrets or a local Ruby install.
4. The license is MIT. The template says to consider which license applies. This repository had no license file. Copyright starts at the first commit, 2015.
