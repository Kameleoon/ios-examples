# Kameleoon iOS Starter Kit

> The Kameleoon iOS Starter Kit demonstrates Kameleoon experimentation and feature flags.

This repository is home to the Kameleoon starter kit for iOS. Kameleoon is a powerful experimentation and personalization platform for product teams that enables you to make insightful discoveries by testing the features on your roadmap. Discover more at https://kameleoon.com, or see the [developer documentation](https://developers.kameleoon.com).

## Using the Starter Kit

This starter kit provides quickstart instructions for developers using the [Kameleoon iOS SDK](https://developers.kameleoon.com/feature-management-and-experimentation/mobile-sdks/ios-sdk/).

### Prerequisites

Make sure you have the following requirements before you get started:

1. A Kameleoon user account. Visit [kameleoon.com](https://www.kameleoon.com/) to learn more.
2. Ensure Xcode supports iOS version `14.0` (or later).

### Get started

To get started, follow these steps:

1. Clone the repository and open `StarterKit` in Xcode:

```bash
git clone git@github.com:Kameleoon/ios-examples.git
open -a Xcode "ios-examples/StarterKit/StarterKit.xcodeproj/"
```

2. In the `SDKViewModel.swift` file, set your `siteCode`:

```swift
private struct Const {
    static let siteCode = "yourSiteCode" // <---- You should change it to your own siteCode
    static let refreshInterval = 15
    static let timeoutInit = 2000
}
```

3. Run the application.

### Usage

1. Properly setting your siteCode will result in the `SDK Status` section indicating "Ready ✅". If there are any errors, the status will display as "Not Ready 🚫".
2. Tapping the "Get Variation" button opens a new section displaying the variation result for a visitor.

## How it works

### Initialization

Copy the initialization code snippet found in the `SDKViewModel.swift` file into your own code. Make sure you properly handle the possible exceptions.

```swift
private func initKameleoonClient() {
    do {
        let visitorCode: String? = nil
        let config = KameleoonClientConfig(refreshIntervalMinute: 15)
        kameleoonClient = try KameleoonClientFactory.create(
            siteCode: "yourSiteCode",
            visitorCode: visitorCode,
            config: config
        )
        kameleoonClient.runWhenReady(timeoutMilliseconds: 2000) { [weak self] ready in
            // cliens is ready or not ready during timeout
        }
    } catch KameleoonError.siteCodeIsEmpty {
        SDKViewModel.logger.error("Sitecode is empty")
    } catch KameleoonError.visitorCodeInvalid(let visitorCode) {
        SDKViewModel.logger.error("Visitor code '\(visitorCode)' is not valid")
    } catch {
        // You can ignore all errors above and catch only base if you're not interested in specific reason of error
        SDKViewModel.logger.error("Unexpected Error: \(error.localizedDescription)")
    }
}
```

### Visitor code

Visitor code will be randomly generated once and used further, but you can explicitly set the visitor code with following code in `SDKViewModel.swift`:

```swift
let visitorCode: String? = "UserUUID"
```

### Get variation

You can get the variation for a visitor with "Get Variation" button in the app. The buttons runs the code in the code snippet below. Make sure you handle the possible exceptions.

```swift
func getVariation() {
    do {
        let variationKey = try kameleoonClient.getFeatureVariationKey(featureKey: params.featureKey)
    } catch KameleoonError.sdkNotReady {
        // SDK isn't ready
    } catch KameleoonError.Feature.notFound(let featureKey) {
        // SDK configuration doesn't contain a feature key
    } catch KameleoonError.Feature.environmentDisabled(let featureKey, let env) {
        // Feature key is disabled for certain environment
    } catch {
        // You can ignore all errors above and catch only base error, if you're not interested in specific reason of error
    }
}
```
