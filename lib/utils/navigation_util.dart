import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../widgets/webview/web_page.dart';

/// @author jd

class NavigationUtil {
  factory NavigationUtil.getInstance() => _getInstance();
  NavigationUtil._internal();
  static NavigationUtil? _instance;
  static NavigationUtil _getInstance() {
    return _instance = _instance ?? NavigationUtil._internal();
  }

  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  Future<dynamic>? _pushNamed(
    String routeName, {
    Object? arguments,
  }) {
    return navigatorKey.currentState
        ?.pushNamed(routeName, arguments: arguments);
  }

  Future<dynamic>? _push(Widget page) {
    return navigatorKey.currentState
        ?.push(CupertinoPageRoute<dynamic>(builder: (BuildContext context) {
      return page;
    }));
  }

  Future<dynamic>? _pushReplacementNamed(
    String routeName, {
    Object? arguments,
  }) {
    return navigatorKey.currentState?.pushReplacementNamed(routeName);
  }

  Future<dynamic>? _pushReplacement(Widget page) {
    return navigatorKey.currentState?.pushReplacement(
        CupertinoPageRoute<dynamic>(builder: (BuildContext context) {
      return page;
    }));
  }

  void _goBack() {
    navigatorKey.currentState?.pop();
  }

  void _popToRoot() {
    navigatorKey.currentState?.popUntil(
      (Route<dynamic> route) => route.isFirst,
    );
    //route返回的是false则从会路由队列清除。
    // navigatorKey.currentState.pushAndRemoveUntil(
    //   CupertinoPageRoute<dynamic>(
    //     builder: (_) => JDScaffoldPage(),
    //   ),
    //   (route) => false,
    // );
  }

  void _pushWeb(
      {String? title, String? titleId, String? url, bool isHome: false}) {
    if (url == null || url.isEmpty) return;
    if (url.endsWith(".apk")) {
      launchInBrowser(url, title: title ?? titleId);
    } else {
      navigatorKey.currentState?.push(
        CupertinoPageRoute<void>(
          builder: (BuildContext ctx) => WebPage(
            title: title,
            url: url,
          ),
        ),
      );
    }
  }

  static Future<dynamic>? pushNamed(
    String routeName, {
    Object? arguments,
  }) {
    return NavigationUtil.getInstance()
        ._pushNamed(routeName, arguments: arguments);
  }

  static Future<dynamic>? push(Widget page) {
    return NavigationUtil.getInstance()._push(page);
  }

  static Future<dynamic>? pushReplacementNamed(
    String routeName, {
    Object? arguments,
  }) {
    return NavigationUtil.getInstance()
        ._pushReplacementNamed(routeName, arguments: arguments);
  }

  static Future<dynamic>? pushReplacement(Widget page) {
    return NavigationUtil.getInstance()._pushReplacement(page);
  }

  static void goBack() {
    NavigationUtil.getInstance()._goBack();
  }

  static void popToRoot() {
    NavigationUtil.getInstance()._popToRoot();
  }

  static void pushWebView(
      {String? title, String? titleId, String? url, bool isHome: false}) {
    NavigationUtil.getInstance()
        ._pushWeb(title: title, titleId: titleId, url: url, isHome: isHome);
  }

  static Future<dynamic> launchInBrowser(String url, {String? title}) async {
    if (await canLaunchUrl(Uri.parse(url))) {
      return await launchUrl(Uri.parse(url));
    } else {
      throw 'Could not launch $url';
    }
  }
}
