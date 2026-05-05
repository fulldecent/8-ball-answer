fastlane documentation
----

# Installation

Make sure you have the latest version of the Xcode command line tools installed:

```sh
xcode-select --install
```

For _fastlane_ installation instructions, see [Installing _fastlane_](https://docs.fastlane.tools/#installing-fastlane)

# Available Actions

### bump_version

```sh
[bundle exec] fastlane bump_version
```

Bump the marketing version. Pass bump:patch (default), bump:minor, or bump:major

### bump_build

```sh
[bundle exec] fastlane bump_build
```

Bump only the build number (used before each beta upload)

----


## iOS

### ios screenshots

```sh
[bundle exec] fastlane ios screenshots
```

Capture App Store screenshots for iPhone, iPad, and Apple Watch

### ios upload_screenshots

```sh
[bundle exec] fastlane ios upload_screenshots
```

Upload screenshots to App Store Connect

### ios screenshots_and_upload

```sh
[bundle exec] fastlane ios screenshots_and_upload
```

Generate screenshots and upload them to App Store Connect

### ios beta

```sh
[bundle exec] fastlane ios beta
```

Build a signed release .ipa and upload it to TestFlight (uses altool)

### ios beta_pilot

```sh
[bundle exec] fastlane ios beta_pilot
```

Legacy iOS TestFlight upload via fastlane-pilot. Currently fails with stale 'previousBundleVersion' errors; kept as a fallback while Apple's ContentDelivery service is misbehaving.

### ios beta_altool

```sh
[bundle exec] fastlane ios beta_altool
```

Same as :beta but uploads via `xcrun altool` directly. Use this if `upload_to_testflight` errors with a stale previousBundleVersion mismatch.

### ios build_release

```sh
[bundle exec] fastlane ios build_release
```

Build the signed release .ipa without uploading

### ios release

```sh
[bundle exec] fastlane ios release
```

Capture screenshots, attach the latest TestFlight build, and submit for review

----


## Mac

### mac beta

```sh
[bundle exec] fastlane mac beta
```

Build a signed macOS .pkg and upload it to TestFlight

### mac release

```sh
[bundle exec] fastlane mac release
```

Submit the latest macOS TestFlight build for App Store review

----

This README.md is auto-generated and will be re-generated every time [_fastlane_](https://fastlane.tools) is run.

More information about _fastlane_ can be found on [fastlane.tools](https://fastlane.tools).

The documentation of _fastlane_ can be found on [docs.fastlane.tools](https://docs.fastlane.tools).
