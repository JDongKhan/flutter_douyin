import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'colors_style.dart';
import 'dimens_style.dart';

const TextStyle listTitleStyle = TextStyle(
  fontSize: JDDimens.font_sp14,
  color: ColorsStyle.darkColor,
  fontWeight: FontWeight.bold,
);

const TextStyle listContentStyle = TextStyle(
  fontSize: JDDimens.font_sp12,
  color: ColorsStyle.normalTextColor,
);

const TextStyle listExtraStyle = TextStyle(
  fontSize: JDDimens.font_sp12,
  color: ColorsStyle.grayColor,
);

const Decoration bottomDecoration = BoxDecoration(
  border: Border(
    bottom: BorderSide(width: 0.33, color: ColorsStyle.divider),
  ),
);

//统一app style
AppBar myAppBar({
  Key? key,
  Widget? leading,
  bool automaticallyImplyLeading = true,
  Widget? title,
  double elevation = 1,
  List<Widget>? actions,
  PreferredSizeWidget? bottom,
  Color? backgroundColor,
  Color? foregroundColor,
  Brightness? brightness,
  IconThemeData? iconTheme,
  IconThemeData? actionsIconTheme,
  TextTheme? textTheme,
  bool primary = true,
  bool? centerTitle,
  double? titleSpacing,
  double? leadingWidth,
  SystemUiOverlayStyle? systemOverlayStyle,
}) {
  return AppBar(
    key: key,
    leading: leading,
    title: title,
    actions: actions,
    bottom: bottom,
    elevation: elevation,
    backgroundColor: backgroundColor,
    foregroundColor: foregroundColor,
    brightness: brightness,
    iconTheme: iconTheme,
    actionsIconTheme: actionsIconTheme,
    textTheme: textTheme,
    primary: primary,
    centerTitle: centerTitle,
    titleSpacing: titleSpacing,
    leadingWidth: leadingWidth,
    systemOverlayStyle: systemOverlayStyle,
  );
}
