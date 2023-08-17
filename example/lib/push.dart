import 'package:flutter/material.dart';
import 'package:umeng_push_sdk/umeng_push_sdk.dart';

import 'helper.dart';

const _TAG = "PushSample";

class Push extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _PushState();
  }
}

class _PushState extends State<Push> with AutomaticKeepAliveClientMixin {
  TextEditingController controller = TextEditingController();

  late Map<String, VoidCallback?> methods;

  int badgeNumber = 0;

  @override
  void initState() {
    super.initState();
    methods = {
      'agree': () async => UmengHelper.agree().then((value) =>
          UmengPushSdk.register("5f69a20ba246501b677d0923", "AppStore")),
      'clear': () {
        controller.text = "";
      },
      'openUmengLog': () async => UmengPushSdk.setLogEnable(true),
      'closeUmengLog': () async => UmengPushSdk.setLogEnable(false),
      'register': () async =>
          UmengPushSdk.register("5f69a20ba246501b677d0923", "AppStore"),
      'getDeviceToken': () async {
        String? deviceToken = await UmengPushSdk.getRegisteredId();
        if (deviceToken != null) {
          controller.text += deviceToken + "\n";
        }
      },
      'addBadge': () async {
        bool? result = await UmengPushSdk.setBadge(++badgeNumber);
        controller.text += "addBadge $badgeNumber result: $result \n";
        print("$_TAG addBadge $badgeNumber result: $result");
      },
      'reduceBadge': () async {
        if (--badgeNumber < 0) {
          badgeNumber = 0;
        }
        bool? result = await UmengPushSdk.setBadge(badgeNumber);
        controller.text += "reduceBadge $badgeNumber result: $result \n";
        print("$_TAG reduceBadge $badgeNumber result: $result");
      },
      'clearBadge': () async {
        badgeNumber = 0;
        bool? result = await UmengPushSdk.setBadge(badgeNumber);
        controller.text += "clearBadge $badgeNumber result: $result \n";
        print("$_TAG clearBadge result: $result");
      },
      'openPush': () async => UmengPushSdk.setPushEnable(true),
      'closePush': () async => UmengPushSdk.setPushEnable(false),
      'addAlias': () async => controller.text +=
          (await UmengPushSdk.addAlias("myAlias", "SINA_WEIBO")).toString() +
              "\n",
      'removeAlias': () async => controller.text +=
          (await UmengPushSdk.removeAlias("myAlias", "SINA_WEIBO")).toString() +
              "\n",
      'setAlias': () async => controller.text =
          (await UmengPushSdk.setAlias("myAlias", "SINA_WEIBO")).toString(),
      'addTags': () async => controller.text +=
          (await UmengPushSdk.addTags(["myTag1", "myTag2", "myTag3"]))
                  .toString() +
              "\n",
      'removeTags': () async => controller.text +=
          (await UmengPushSdk.removeTags(["myTag1", "myTag2", "myTag3"]))
                  .toString() +
              "\n",
      'getAllTags': () async =>
          controller.text += (await UmengPushSdk.getTags()).toString() + "\n"
    };

    UmengPushSdk.setTokenCallback((deviceToken) {
      print("$_TAG deviceToken:" + deviceToken);
      controller.text += deviceToken + "\n";
    });

    UmengPushSdk.setMessageCallback((msg) {
      print("$_TAG receive custom:" + msg);
      controller.text += msg + "\n";
    });

    UmengPushSdk.setNotificationCallback((receive) {
      print("$_TAG receive:" + receive);
      controller.text += "receive:" + receive + "\n";
    }, (open) {
      print("$_TAG open:" + open);
      controller.text += "open:" + open + "\n";
    });

    //注册推送
    UmengPushSdk.setLogEnable(true);

    UmengHelper.isAgreed().then((value) => {
          if (value!)
            {UmengPushSdk.register("5f69a20ba246501b677d0923", "AppStore")}
        });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
        appBar: AppBar(
          title: Text('PushSample'),
        ),
        body: Center(
          child: Column(
            children: <Widget>[
              TextField(
                maxLines: 5,
                controller: controller,
              ),
              Expanded(
                  child: Wrap(
                runSpacing: 10,
                spacing: 10,
                children: methods.keys
                    .map((e) => ElevatedButton(
                          child: Text(e),
                          onPressed: methods[e],
                        ))
                    .toList(),
              )),
            ],
          ),
        ));
  }

  @override
  bool get wantKeepAlive => true;
}
