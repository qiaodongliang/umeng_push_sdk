import 'package:flutter/material.dart';

import 'push.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  var _pageController = PageController();

  final _bodyList = [
    Push(),
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: PageView(
          controller: _pageController,
          children: _bodyList,
          onPageChanged: pageControllerTap,
          physics: NeverScrollableScrollPhysics(),
        ),
      ),
    );
  }

  void pageControllerTap(int index) {
    setState(() {});
  }

  void onTap(int index) {
    _pageController.jumpToPage(index);
  }
}
