# survicate_flutter_sdk_example

Demonstrates how to use the survicate_flutter_sdk plugin.

## Running the app

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
* Reset: if you are testing, this button is useful to reset all data that has been sent to Survicate so it can be sent again.
* Register survey activity listeners: registers listeners that will be called upon some activities, such as "survey displayed", "question answered", "survey closed" and "survey completed". Upon being called, the values of these callbacks will appear on the example app screen.
* Unregister survey activity listeners: unregisters the above listeners.

The idea of having these buttons is so you can go to your Survicate account and create surveys with specific targeting in settings so as to be displayed upon the sending of the events triggered by clicking the available buttons.

For instance, we can create a survey that will be targeted to be displayed when user attributes `First Name` is `USER`. In this case, this survey will be displayed when you click the button `Set user id = 1 and first name = USER`.

Refer to [Survicate docs](https://help.survicate.com/en/) to learn the details of how to create and configure surveys in the platform.

## Implementation details

We obviously recommend you take a look at the implementation of the example app as a general guide on how to use the Survicate Flutter SDK. Roughly, all you need to do is instantiate the class:

```dart
/// ...
class _MyAppState extends State<MyApp> {

  SurvicateFlutterSdk survicateFlutterSdk;

///...

  @override
  void initState() {
    super.initState();
    survicateFlutterSdk ??= SurvicateFlutterSdk();
  }
///...
```

After that, you can start calling the available methods in the SDK:

```dart
/// ...
    RaisedButton(
        onPressed: () {
            survicateFlutterSdk.invokeEvent('SURVEY');
        },
        child: Text('Invoke event SURVEY'),
     ),
///...
```

Please follow the [SDK documentation](https://pub.dev/documentation/survicate_flutter_sdk/latest/) to better understand the available methods arguments and responses.