fastlane documentation
----

# Installation

Make sure you have the latest version of the Xcode command line tools installed:

```sh
xcode-select --install
```

For _fastlane_ installation instructions, see [Installing _fastlane_](https://docs.fastlane.tools/#installing-fastlane)

# Available Actions

### ship_testflight

```sh
[bundle exec] fastlane ship_testflight
```

Upload this commit to TestFlight for iOS and macOS and distribute it to the internal group. The marketing version comes from VERSION. The build number is not committed.

### generate_screenshots

```sh
[bundle exec] fastlane generate_screenshots
```

Generate iPhone, iPad, and Mac screenshots for every language in answers-by-locale.json. Files are written under fastlane/screenshots and are not committed.

### submit_app_store

```sh
[bundle exec] fastlane submit_app_store
```

Submit the TestFlight build to App Store review for iOS and macOS. Pass build_number:. Screenshots must already be under fastlane/screenshots. What's New is the newest CHANGELOG.md section.

----

This README.md is auto-generated and will be re-generated every time [_fastlane_](https://fastlane.tools) is run.

More information about _fastlane_ can be found on [fastlane.tools](https://fastlane.tools).

The documentation of _fastlane_ can be found on [docs.fastlane.tools](https://docs.fastlane.tools).
