# 友盟推送SDK插件 Flutter
## 集成
在工程 pubspec.yaml 中加入 dependencies

```
dependencies: 
    umeng_push_sdk: 
        <!-- 2.1.0 -->
        # 友盟推送Flutter插件的路径
        path: ../ 
```

## 配置

创建应用请参考：https://developer.umeng.com/docs/67966/detail/99884

### Android

在 `/android/app/build.gradle` 中添加下列代码：

```groovy
android {
  defaultConfig {
    applicationId "您的应用包名"

    ndk {
        abiFilters 'armeabi', 'armeabi-v7a', 'arm64-v8a'
    }

    manifestPlaceholders = [
            UMENG_APPKEY: '您申请的appkey',
            UMENG_MESSAGE_SECRET: '您申请的message secret',
            UMENG_CHANNEL: '您的应用发布渠道',

            HUAWEI_APP_ID: '您申请的华为通道appid',

            HONOR_APP_ID: '您申请的荣耀通道appid',

            XIAOMI_APP_ID: '您申请的小米通道appid',
            XIAOMI_APP_KEY: '您申请的小米通道appkey',

            OPPO_APP_KEY: '您申请的OPPO通道appkey',
            OPPO_APP_SECRET: '您申请的OPPO通道app secret',

            VIVO_APP_ID: '您申请的VIVO通道appid',
            VIVO_APP_KEY: '您申请的VIVO通道appkey',

            MEIZU_APP_ID: '您申请的魅族通道appid',
            MEIZU_APP_KEY: '您申请的魅族通道appkey',
    ]
  }

}
```

厂商消息下发时，Activity路径传入：com.umeng.message.UmengOfflineMessageActivity

### iOS

证书配置请参考文档：https://developer.umeng.com/docs/67966/detail/66748

AppDelegate.swift中需要进行的配置：

1. didFinishLaunchingWithOptions方法中设置消息代理

```swift
@implementation AppDelegate

override func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
	...
        UNUserNotificationCenter.current().delegate = self
	...
    }
```

2. 处理willPresentNotification方法回调

```swift
override func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        let userInfo: [AnyHashable: Any] = notification.request.content.userInfo
        UmengPushSdkPlugin.didReceiveUMessage(userInfo)
        completionHandler([.sound, .badge, .alert])
    }
```

3. 处理didReceiveNotificationResponse方法回调

```swift
override func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        let userInfo: [AnyHashable: Any] = response.notification.request.content.userInfo
        UmengPushSdkPlugin.didOpenUMessage(userInfo)
    }
```

4. 处理didRegisterForRemoteNotificationsWithDeviceToken方法回调

```swift
override func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        UmengPushSdkPlugin.didRegisterDeviceToken(deviceToken)
    }
```

## 使用 

```dart
import 'package:umeng_push_sdk/umeng_push_sdk.dart';
```

具体使用请下载[sdk](https://pub.dev/packages/umeng_push_sdk/versions)，参考sdk中的example工程。
