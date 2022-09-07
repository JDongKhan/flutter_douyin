import 'package:flutter/services.dart' show rootBundle;

/// @author jd
///获取本地资源
class AssetBundleUtils {
  static String getImgPath(String? name, {String format: 'png'}) {
    if (name == null) {
      return "";
    }
    return 'assets/images/$name.$format';
  }

  static String getIconPath(String? name, {String format: 'png'}) {
    if (name == null) {
      return "";
    }
    return 'assets/icons/$name.$format';
  }

  static Future<String> loadString(String path) async {
    return rootBundle.loadString(path);
  }
}
