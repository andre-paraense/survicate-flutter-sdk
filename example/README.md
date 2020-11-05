# survicate_flutter_sdk_example

Demonstrates how to use the survicate_flutter_sdk plugin.

## Example

In order to run the example app, the first step is to create an account at [survicate.com](https://survicate.com). Sign up for free and find your workspace key in the Tracking Code section.

Secondly, configure your workspace key in the `AndroidManifest.xml` file in the [`example/android/app/src/main`](./android/app/src/main) folder.

```xml
<application
    android:name=".MyApp"
>
    <!-- ... -->
    <meta-data android:name="com.survicate.surveys.workspaceKey" android:value="YOUR_WORKSPACE_KEY"/>
</application>
```

Thirdly, also configure your workspace key in the `Info.plist` file in the [`example/ios/Runner`](./ios/Runner) folder.

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

After these three first steps, you are ready to run the example app in Android and/or iOS, correctly connected to your Survicate account.


