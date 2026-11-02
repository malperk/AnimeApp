# AnimeApp

Studio Ghibli film browser for iOS, implemented with UIKit, RxSwift and Moya.

## Requirements

- Xcode 27 or later (including its Swift compiler and iOS SDK)
- iOS 15.0 or later
- Internet connection to fetch Swift packages and film metadata

## Getting started

1. Clone this repository.
2. Open `AnimeApp.xcodeproj` in Xcode. **Do not open the old CocoaPods workspace and do not run `pod install`.**
3. Let Xcode resolve the project’s Swift Package Manager dependencies (File → Packages → Resolve Package Versions if needed).
4. Select the `AnimeApp` scheme and build/run on an iOS simulator.

To resolve packages and build from the command line:

```sh
xcodebuild -resolvePackageDependencies -project AnimeApp.xcodeproj -scheme AnimeApp
xcodebuild -project AnimeApp.xcodeproj -scheme AnimeApp -destination 'generic/platform=iOS Simulator' CODE_SIGNING_ALLOWED=NO build
```

## Swift Package Manager dependencies

These products are linked to the **AnimeApp** target:

| Package | Version requirement | Products |
| --- | --- | --- |
| [RxSwift](https://github.com/ReactiveX/RxSwift) | `6.10.2 ..< 7.0.0` | `RxSwift`, `RxCocoa` |
| [Moya](https://github.com/Moya/Moya) | `15.0.3 ..< 16.0.0` | `Moya`, `RxMoya` |

Alamofire and other upstream packages are managed as transitive SPM dependencies.
`Tabman`, `Pageboy`, and `PureLayout` are not used by the application and were removed rather than migrated.

The iOS deployment target was raised from iOS 11.0 to **iOS 15.0** to work with current Xcode and the latest compatible transitive packages. The app continues using Swift **5 language mode**.

> The repository was migrated by updating the Xcode project references and Swift API usage. Xcode build and XCTest execution should be verified on a macOS machine; they were not executed by the migration automation.
