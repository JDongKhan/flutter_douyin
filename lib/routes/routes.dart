import 'package:flutter/cupertino.dart';

import '/page/splash/splash_page.dart';
import '../page/error/not_find_page.dart';

final Map<String, WidgetBuilder> _routes = <String, WidgetBuilder>{
  '/': (BuildContext context) => SplashPage(),
};

Map<String, WidgetBuilder> get routes => _routes;

class Routers {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final WidgetBuilder? builder = routes[settings.name];
    return CupertinoPageRoute<dynamic>(
      builder: builder ?? (BuildContext context) => NotFindPage(),
    );
  }
}
