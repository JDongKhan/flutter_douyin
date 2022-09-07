import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '/utils/storage_utils.dart';
import 'path_utils.dart';

/// @author jd

class AppInfo {
  /// 临时目录 eg: cookie
  static Directory? temporaryDirectory;
  //初始化
  static void init(VoidCallback callback) {
    WidgetsFlutterBinding.ensureInitialized();
    //异步初始化
    AppInfo.delayInit();
    //布局
    callback();
    //强制竖屏
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);

    if (Platform.isAndroid) {
      // 以下两行 设置android状态栏为透明的沉浸。写在组件渲染之后，是为了在渲染后进行set赋值，覆盖状态栏，写在渲染之前MaterialApp组件会覆盖掉这个值。
      const SystemUiOverlayStyle systemUiOverlayStyle =
          SystemUiOverlayStyle(statusBarColor: Colors.transparent);
      SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);
    }
  }

  //初始化全局信息
  // ignore: always_specify_types
  static Future delayInit() async {
    //初始化
    StorageUtil.getInstance();
    //初始化bugly
//    FlutterBugly.init(androidAppId: "your android app id",iOSAppId: "your iOS app id");
//    FlutterBugly.setUserId("user id");
//    FlutterBugly.putUserData(key: "key", value: "value");
//    int tag = 9527;
//    FlutterBugly.setUserTag(tag);
//
    return temporaryDirectory = await PathUtils.getAppTemporaryDirectory();
  }

  //隐藏显示状态栏
  static void toggleFullScreen(bool fullscreen) {
    fullscreen
        ? SystemChrome.setEnabledSystemUIOverlays([])
        : SystemChrome.setEnabledSystemUIOverlays(SystemUiOverlay.values);
  }
}
