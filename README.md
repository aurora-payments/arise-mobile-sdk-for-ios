# ARISE Mobile SDK for iOS

Official iOS SDK for ARISE Payment Platform - enables Tap to Pay on iPhone and payment processing capabilities.

## Requirements

- iOS 15.0+
- Xcode 15.0+
- Swift 5.9+
- iPhone XS or later (for Tap to Pay)

## Installation

### Swift Package Manager

Add the package to your `Package.swift`:

```swift
dependencies: [
    .package(url: "https://github.com/aurora-payments/arise-mobile-ios-sdk.git", from: "1.0.0")
]
```

Then add the dependency to your target:

```swift
.target(
    name: "YourApp",
    dependencies: [
        .product(name: "ARISEMobileSDK", package: "arise-mobile-ios-sdk")
    ]
)
```

### Xcode

1. File → Add Package Dependencies
2. Enter: `https://github.com/aurora-payments/arise-mobile-ios-sdk.git`
3. Select version rule (e.g., "Up to Next Major Version")
4. Click "Add Package"

## Configuration

### Info.plist

Add the following keys to your app's `Info.plist` for Tap to Pay functionality:

```xml
<key>PRODUCT_TEAM_IDENTIFIER</key>
<string>YOUR_PSP_TEAM_ID</string>

<key>NSLocationWhenInUseUsageDescription</key>
<string>Location access is required for Tap to Pay functionality</string>
```

> **Note:** `PRODUCT_TEAM_IDENTIFIER` is ARISE's Apple Team ID required for Tap to Pay on iPhone. You can find it in [Apple Developer Account](https://developer.apple.com/account/resources/certificates) — displayed in the top right corner next to the company name.

### Signing & Capabilities

In Xcode, add the required capabilities for Tap to Pay:

1. Select your app target
2. Go to **Signing & Capabilities** tab
3. Click **"+ Capability"** and add:
   - **"Tap to Pay on iPhone"**
   - **"Near Field Communication Tag Reading"**

This will automatically:
- Create an entitlements file with `com.apple.developer.proximity-reader.payment.acceptance`
- Add NFC entitlement for card reading
- Update your provisioning profile

> **Important:** Tap to Pay capability requires **prior approval from Apple**.
>
> 1. Request access at [developer.apple.com/contact/request/tap-to-pay-on-iphone](https://developer.apple.com/contact/request/tap-to-pay-on-iphone/)
> 2. Fill out the form with your company and app information
> 3. Wait for Apple's approval (this may take time)
> 4. After approval, the capability will appear in your Developer Portal
>
> Without Apple's approval, you will see the error: *"Entitlement com.apple.developer.proximity-reader.payment.acceptance not found"*

### Location Permission Requirement

**Important:** Tap to Pay on iPhone requires location permission to be **granted** by the user.

- The app must request `When In Use` location authorization
- User must **accept** the location permission dialog
- If permission is denied, Tap to Pay functionality will not work
- You can check location permission status using `sdk.ttp.checkCompatibility()` method

```swift
// Check if location permission is granted
let result = sdk.ttp.checkCompatibility()
if result.locationPermission != .granted {
    // Request location permission from user
    locationManager.requestWhenInUseAuthorization()
}
```

## Quick Start

```swift
import ARISEMobileSDK

// Initialize SDK
let sdk = try AriseMobileSdk(environment: .production)

// Authenticate
try await sdk.authenticate(
    clientId: "your-client-id",
    clientSecret: "your-client-secret"
)

// Get payment settings
let settings = try await sdk.getPaymentSettings()

// Process payment with Tap to Pay
let result = try await sdk.processPayment(
    amount: 10.00,
    currency: "USD"
)
```

## Features

- **Tap to Pay on iPhone** - Accept contactless payments
- **Payment Processing** - Sales, refunds, voids
- **Transaction History** - Search and retrieve transactions
- **Device Management** - Register and manage terminals

## License

Copyright © ARISE Payments. All rights reserved.
