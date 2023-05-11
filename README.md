# MoneyKit for iOS

## Overview

MoneyKit for iOS is a quick and secure way to link bank accounts from within your iOS app. The drop-in framework handles connecting to a financial institution in your app (credential validation, multi-factor authentication, error handling, etc.) without passing sensitive information to your server.

## Installation

MoneyKit for iOS is an embeddable framework that is bundled and distributed with your application. There are several ways to obtain the necessary files and keep them up-to-date; we recommend using Swift Package Manager. Regardless of what you choose, submitting a new version of your application with the updated MoneyKit.xcframework to the App Store is required.

#### Swift Package Manager

1. To integrate MoneyKit using Swift Package Manager, Swift version >= 5.5 is required.
2. In your Xcode project from the Project Navigator select your project, activate the Package Dependencies tab and click on the plus symbol to open the Add Package popup window:
3. Enter the MoneyKit package URL https://github.com/moneykit/moneykit-ios into the search bar in the top right corner of the Add Package popup window.
4. Select the moneykit-ios package.
5. Choose your Dependency Rule (we recommend Up to Next Major Version).
6. Select the project to which you would like to add MoneyKit, then click Add Package.
7. Select the MoneyKit package and click Add Package.
8. Verify that the MoneyKit package was properly added as a dependency to your project.
9. Select your application target and ensure that the MoneyKit framework is embedded into your application.

#### Manual Install

Get the latest version of the MoneyKit.xcframework and embed it into your application, for example by dragging and dropping the XCFramework bundle onto the Embed Frameworks build phase of your application target in Xcode.

## Upgrading

New versions of MoneyKit.xcframework are released frequently, at least once every few months. We recommend you keep up to date to provide the best experience in your application.

## Example Application

Before building and running the example application replace any placeholder strings in the code with the appropriate value so that MoneyKit is configured properly. For convenience the Xcode placeholder strings are also marked as compile-time warnings.

Full detailed instructions on how to integrate with MoneyKit for iOS can be found in our main documentation at https://docs.moneykit.com/.
