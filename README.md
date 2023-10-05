# ndream-unity-webview

ndream-unity-webview is a plugin for Unity 5 and higher.
The goal is to bring it to the highest possible performance in its respective target use cases.

It is opmtised for usage in the [AirConsole Unity Plugin](https://github.com/airconsole/airconsole-unity-plugin) where it provides

| Platform | Features                                                     |
| -------- | ------------------------------------------------------------ |
| Android  | native WebView, WebRTC, WebSockets                           |
| OSX      | WebRTC, WebSockets                                           |
| Windows  | At this time,  Windows is not supported as per version 1.0.0 |

unity-webview is derived from
- keijiro-san's https://github.com/keijiro/unity-webview-integration
- GREE Incs https://github.com/gree/unity-webview (fork)

## Sample Project

It is placed under `sample/`. You can open it and import the plugin as
below:

1. Open `sample/Assets/Sample.unity`.
2. Open `dist/ndream-unity-webview.unitypackage` and import all files. It
   might be easier to extract `dist/ndream-unity-webview.zip` instead if
   you've imported unity-webview before.

## Platform Specific Notes

### Mac (Editor)

The implementiation does not support rendering a webview.

### Android

#### hardwareAccelerated

The main activity should have `android:hardwareAccelerated="true"`, otherwise a webview won't run
smoothly. Depending on unity versions, we need to set it as below (basically this will be done by
post-process build scripts).

##### Unity 2018.1 or newer

Based on the technique discussed in
https://forum.unity.com/threads/android-hardwareaccelerated-is-forced-false-in-all-activities.532786/ and https://github.com/Over17/UnityAndroidManifestCallback, `Assets/Plugins/Editor/UnityWebViewPostprocessBuild.cs` edit the manifest to set `android:hardwareAccelerated="true"`. Please note this works with the `gradle` (not `internal`) build setting.

##### Unity 2018.0 or older

After the initial build, `Assets/Plugins/Editor/UnityWebViewPostprocessBuild.cs` will copy
`sample/Temp/StatingArea/AndroidManifest-main.xml` to
`sample/Assets/Plugins/Android/AndroidManifest.xml`, edit the latter to add
`android:hardwareAccelerated="true"` to `<activity
android:name="com.unity3d.player.UnityPlayerActivity" ...`. Then you need to build the app again to
reflect this change.

*NOTE: Unity 5.6.1p4 or newer (including 2017 1.0) seems to fix the following issue. cf. https://github.com/gree/unity-webview/pull/212#issuecomment-314952793*

For Unity 5.6.0 and 5.6.1 (except 5.6.1p4), you also need to modify `android:name` from
`com.unity3d.player.UnityPlayerActivity` to
`net.gree.unitywebview.CUnityPlayerActivity`. This custom activity
implementation will adjust Unity's SurfaceView z order. Please refer
`plugins/Android/src/net/gree/unitywebview/CUnityPlayerActivity.java`
and `plugins/Android/src/net/gree/unitywebview/CUnityPlayer.java` if
you already have your own activity implementation.
