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

When you run the example app, you will notice there are a few buttons:
* Invoke event SURVEY: sends an event with the name `SURVEY` to Survicate.
* Enter screen SCREEN: sends an entered screen event with the screen name `SCREEN` to Survicate.
* Leave screen SCREEN: sends a left screen event with the screen name `SCREEN` to Survicate.
* Set user id = 1 and first name = USER: sends user traits with the correspondent values to Survicate.
* Reset: if you are testing, this button is useful to reset all that has been sent to Survicate so it can be sent again.
* Register survey activity listeners: registers listeners that will be called upon some activities, such as "survey displayed", "questions answered", "survey closed" and "survey completed". Upon being called, the values of these callbacks will appear on the example app screen.
* Unregister survey activity listeners: unregisters the above listeners.



