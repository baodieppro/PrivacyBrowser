#  Privacy Browser

A simple web browser with tracker blocking capabilities.

## Getting Started

This project uses [CocoaPods](https://cocoapods.org/) for dependency management. Make sure that it's installed. 

After cloning this repository, run `pod install` to install project dependencies.

## Dependencies

In this project, following 3rd party libraries are used:

* [iOSSnapshotTestCase](https://github.com/uber/ios-snapshot-test-case)
* [OHHTTPStubs](https://github.com/AliSoftware/OHHTTPStubs)

## Testing

Run `fastlane scan` to build and run tests.

* In addition to using XCTest framework for unit and UI testing, [iOSSnapshotTestCase](https://github.com/uber/ios-snapshot-test-case) is also used for verifying visual appearances of UI components. Please refer to the [`Screenshots`](https://github.com/eraycetiner/PrivacyBrowser/tree/master/PrivacyBrowserTests/ReferenceImages_64) directory for reference snapshots.

*  For testing purposes, a web server is automatically launched in the test pre-run actions. Please refer to the [`MockServer`](https://github.com/eraycetiner/PrivacyBrowser/tree/master/MockServer) directory for mocked web pages and scripts that start and stop the web server.
