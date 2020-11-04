# Survicate SDK for Flutter

![](https://github.com/andre-paraense/survicate-flutter-sdk/workflows/CI/badge.svg) [![codecov](https://codecov.io/gh/andre-paraense/survicate-flutter-sdk/branch/master/graph/badge.svg)](https://codecov.io/gh/andre-paraense/survicate-flutter-sdk) [![License: MIT](https://img.shields.io/badge/License-LGPL3.0-green.svg)](https://opensource.org/licenses/LGPL-3.0) [![Pub](https://img.shields.io/pub/v/survicate_flutter_sdk.svg)](https://pub.dartlang.org/packages/survicate_flutter_sdk)

This is a Survicate SDK for Flutter.

You are welcome to [contribute](CONTRIBUTING.md).

## Supported versions

Survicate's Mobile SDK works on:

* Android at least on version 4.4
* iOS at least on version 10

To use this SDK, you need an account at [survicate.com](https://survicate.com). Sign up for free and find your workspace key in Tracking Code section.

## Getting started

Check Survicate's [documentation](https://help.survicate.com/en/) for in-depth instructions on configuring and using Survicate.

To use this plugin, add `survicate_flutter_sdk` as a [dependency in your pubspec.yaml file](https://flutter.io/platform-plugins/).

Import `package:survicate_flutter_sdk/survicate_flutter_sdk.dart` and instantiate `SurvicateSDKFlutter`.

### Android integration

Configure your workspace key in `AndroidManifest.xml` file. Create `meta-data: com.survicate.surveys.workspaceKey`.

```xml
<application
    android:name=".MyApp"
>
    <!-- ... -->
    <meta-data android:name="com.survicate.surveys.workspaceKey" android:value="YOUR_WORKSPACE_KEY"/>
</application>
```

### iOS integration

Add workspace key to your `Info.plist` file. Create the `Survicate` Dictionary and define the `WorkspaceKey` String in `Survicate` Dictionary.

```xml
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
	[...]
	<key>Survicate</key>
	<dict>
	    <key>WorkspaceKey</key>
	    <string>YOUR_WORKSPACE_KEY</string>
	</dict>
	[...]
</dict>
</plist>
```

## Example

There is an [example](./example) app that demonstrates how to use the plugin.

## Contributing

We encourage pull requests and other contributions from the community. Check out our [contributing guidelines](CONTRIBUTING.md) for instructions on how to contribute to this SDK.

## About Survicate

Survicate gives you the ability to send targeted surveys to your users within your app in a simple, easy, and fast way for you as well as Survicate application users. Within Survicate Panel you can choose criteria that your users have to meet in order for the surveys to appear in different ways. The users matching the conditions will see the survey automatically. You can set the criteria to be custom user attributes or user events you created.

Available conditions:
* Screen
* Event
* User attributes
* Language
* Known user
* Operating system

Make sure to list all the screens and events described in your application. Once you got this covered, you or any person responsible for creating and managing surveys will be able to trigger them from Survicate panel with no need for you to update the application.