# Kameleoon .NET Demo Application

> The Kameleoon .NET Demo Application demonstrates how to use Kameleoon experimentation and feature flags.

This repository is home to the Kameleoon Demo Application for .NET. Kameleoon is a powerful experimentation and personalization platform for product teams that enables you to make insightful discoveries by testing the features on your roadmap. Discover more at https://kameleoon.com, or see the [developer documentation](https://developers.kameleoon.com).

## Using the demo application

This demo application demonstrates advanced using of [Kameleoon .NET SDK](https://developers.kameleoon.com/feature-management-and-experimentation/web-sdks/csharp-sdk/) with frequently encountered use cases.

### Prerequisites

Make sure you have the following requirements before you get started:

1. A Kameleoon user account. Visit [kameleoon.com](https://www.kameleoon.com/) to learn more.
2. `.NET 7.0` (or later) installed.

### Get started

To get started, follow these steps:

1. Clone this repository and move into the cloned directory:

```bash
git clone git@github.com:Kameleoon/dotnet-examples.git
cd dotnet-examples/DemoApplication
```

2. In the `appsettings.json` file, set your `ClientId`, `ClientSecret`, and `SiteCode`. To start the server locally, leave `TopLevelDomain` as `localhost`. If you want to deploy on remote server, set the `TopLevelDomain` to your actual top-level domain:

```json
"Kameleoon": {
    "SiteCode": "siteCode",
    "ClientId": "clientId",
    "ClientSecret": "clientSecret",
    "TopLevelDomain": "localhost"
}
```

3. Run the server. By default, the server runs locally on port `4300`:

```bash
dotnet run
```

### Basic use cases

> [Swagger](http://localhost:4300/swagger) is available.

Here is a list of most common ways you might use our SDK:

1. Add targeting and retrieve a variation key for a visitor:
```
http://localhost:4300/Basic?index=<index>&value=<value>&featureKey=<featureKey>
```

2. Fetch the remote data for the visitor and get the variable value for the assigned variation.
```
http://localhost:4300/Remote?featureKey=<featureKey>&variableKey=<variableKey>
```

3. Get all feature flags and check to see if they are active for a visitor or not.
```
http://localhost:4300/AllFlags
```

### Advanced use cases

> [Swagger](http://localhost:4300/swagger) is available.

The SDK methods are divided into separate calls for testing if you have problems with your own implementation.

1. Get a list of keys for the available feature flags:
```
http://localhost:4300/FeatureList
```

2. Add data for visitor and flush to Kameleoon Data API:
```
http://localhost:4300/AddData?index=<index>&value=<value>
```

3. Get active feature flags for the visitor:
```
http://localhost:4300/ActiveFeatures
```

4. Check to see if the feature is active for the visitor:
```
http://localhost:4300/FeatureActive?featureKey=<featureKey>
```

5. Get a variation key of assigned variation for the visitor:
```
http://localhost:4300/FeatureVariationKey?featureKey=<featureKey>
```

6. Get a variable value key of the assigned variation for the visitor:
```
http://localhost:4300/FeatureVariable?featureKey=<featureKey>&variableKey=<variableKey>
```

7. Get the engine tracking code for the assigned variation for the visitor:
```
http://localhost:4300/EngineTrackingCode?featurekey=<featureKey>
```

8. Get the remote data for the visitor:
```
http://localhost:4300/RemoteVisitorData
```
