import 'package:flutter/cupertino.dart';

import 'config/services_path.dart';

/// @author jd

///环境配置
enum Environment {
  ///prd
  prd,

  ///sit
  sit,

  ///pre
  pre,
}

class Environments {
  ///初始化

  void init({
    String env = 'prd',
    bool debug = false,
  }) {
    if (env == 'prd') {
      environment = Environment.prd;
    } else if (env == 'sit') {
      environment = Environment.sit;
    } else if (env == 'pre') {
      environment = Environment.pre;
    }
    debugPrint('初始化环境:$environment');
    this.debug = debug;
    servicesPath = ServicesPath(environment);
  }

  ///服务配置
  late ServicesPath servicesPath;

  ///环境
  late Environment environment;

  ///是否是debug
  bool debug = false;
}

Environments environments = Environments();
