# Kameleoon iOS Demo Application

> The Kameleoon iOS Demo Application demonstrates how to use Kameleoon experimentation and feature flags.

This repository is home to the Kameleoon Demo Application for iOS. Kameleoon is a powerful experimentation and personalization platform for product teams that enables you to make insightful discoveries by testing the features on your roadmap. Discover more at https://kameleoon.com, or see the [developer documentation](https://developers.kameleoon.com).

## Using the demo application

This demo application demonstrates advanced uses of [Kameleoon iOS SDK](https://developers.kameleoon.com/feature-management-and-experimentation/mobile-sdks/ios-sdk/) with frequently encountered use cases.

### Prerequisites

Make sure you have the following requirements before you get started:

1. A Kameleoon user account. Visit [kameleoon.com](https://www.kameleoon.com/) to learn more.
2. Ensure Xcode supports iOS version `14.0` (or later).

### Get started

To get started, follow these steps:

1. Clone the repository and open `DemoApplication` in Xcode:

```bash
git clone git@github.com:Kameleoon/ios-examples.git
open -a Xcode "ios-examples/DemoApplication/DemoApplication.xcodeproj/"
```

2. In the `SDKViewModel.swift` file, set your `siteCode`:

```swift
private struct Const {
    static let siteCode = "yourSiteCode" // <---- You should change it to your own siteCode
    static let refreshInterval = 15
    static let timeoutInit = 2000
}
```

### Basic use cases

Here is a list of the most common ways you might use our SDK:
- **Basic:** Add targeting data and retrieve a variation key for a visitor.
- **Remote:** Fetch the remote data for the visitor and get the variable value for the assigned variation.
- **All Flags:** Get all feature flags and check to see if they are active for a visitor or not.

### Advanced use cases

The SDK methods are divided into separate calls for testing if you have problems with your own implementation.

- **Feature List:** Get a list of keys for the available feature flags.
- **Add Data:** Add data for visitor and flush to Kameleoon Data API.
- **Active Features:** Get active feature flags for the visitor.
- **Feature Active:** Check to see if the feature is active for the visitor.
- **Feature Variation:** Get a variation key of the assigned variation for the visitor.
- **Feature Variable:** Get a variable value key of the assigned variation for the visitor.
- **Remote VisitorData:** Get the remote data for the visitor
