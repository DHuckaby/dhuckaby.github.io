---
title: Dynamic launcher icons
hide:
- toc
---

### Pitch
Have you ever wanted to swap your Android app's icon at runtime? It could be useful as a premium feature or as a way for your users to customize the feel of your application. I have a solution that works for the most part, with some drawbacks that will need to be weighed before implementing it into your application.

Starting off this is the exact same method seen in applications such as Discord or Todoist. The main drawback is that the first time we enable this new behavior your application will be closed automatically as your new icon is applied. Subsequent calls to reset or switch to any other icons will not result in your application closing. This is undefined behavior, and I have no workaround for it. If that is fine, let's get into the weeds.

### Activity Alias
Traditionally I have only ever used an [activity-alias](https://developer.android.com/guide/topics/manifest/activity-alias-element) to redirect my launching activity reference when I have moved the actual class into a new package. We are going to be leveraging that concept to not only redirect once to our launching activity, but many times depending on how many icons you want. The catch is that by default only one of those should be enabled. That way you can at runtime switch between them by enabling and disabling aliases, resulting in the perception of the icon changing to the user.

```xml
<application  
    android:label="@string/app_name"  
    android:icon="@mipmap/ic_launcher">
	<activity
		android:name=".MainActivity"
		android:exported="true">
		<intent-filter>
			<action android:name="android.intent.action.MAIN" />  
        </intent-filter>
    </activity>
    <activity-alias
	    android:name=".AliasDefault"  
        android:enabled="true"  
        android:exported="true"
        android:targetActivity=".MainActivity">  
        <intent-filter>
	        <action android:name="android.intent.action.MAIN" />  
            <category android:name="android.intent.category.LAUNCHER" />  
        </intent-filter>
    </activity-alias>
    <activity-alias
	    android:name=".AliasAlternative"  
        android:enabled="false"  
        android:exported="true"
        android:icon="@mipmap/ic_launcher_alternative"
        android:targetActivity=".MainActivity">
        <intent-filter>
	        <action android:name="android.intent.action.MAIN" />  
            <category android:name="android.intent.category.LAUNCHER" />  
        </intent-filter>
    </activity-alias> 
</application>
```

### The Weeds
The initial implementation of the activity-alias only showcases a single enabled alias, and a disabled one with an alternative icon applied. This concept does work for more than one disabled alias and can even extend to change the title of your application as well. Digging a bit further we need to understand how we can safely switch between those aliases without impacting our users negatively.

The way we reference an activity-alias in code is via a class called [`ComponentName`](https://developer.android.com/reference/android/content/ComponentName), for example the equivalent of the enabled alias above is `ComponentName(pkg, "$pkg.AliasDefault")`. This is used when communicating with the [`PackageManager`](https://developer.android.com/reference/android/content/pm/PackageManager) class, specifically we want to use it when calling `getComponentEnabledSetting` and `setComponentEnabledSetting`.

At a high level we need to be able to not only enable the currently disabled alias, but also disable the currently enabled alias. If we blindly switch the states it will work, but your application will close automatically every single time you do. If you only want it to happen the first time you need to take into account the original default state. So when enabling the default alias, you just need to set the state to default. Or when disabling the non-default alias, you just need to set the state to default.

I have compiled an [example project](https://github.com/DHuckaby/Chameleon) that does all of this that you can follow as a guide, or just copy/paste it like most do from StackOverflow. I don't mind either way, it is a pretty slick solution once it is in place. Given this is largely in uncharted territories, good luck if you ship it to production.

#### Example project in action
<video controls>
<source src="https://github.com/DHuckaby/Chameleon/raw/refs/heads/main/docs/Screen_recording_20240825_224418.mp4" type="video/mp4">
</video>
