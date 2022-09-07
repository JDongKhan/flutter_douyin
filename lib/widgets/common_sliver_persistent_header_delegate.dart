import 'dart:math';

import 'package:flutter/material.dart';

/**
 *
 * @author jd
 *
 */

class CommonSliverPersistentHeaderDelegate
    extends SliverPersistentHeaderDelegate {
  CommonSliverPersistentHeaderDelegate(
    this.minHeight,
    this.maxHeight,
    this.child,
  );
  final double minHeight;
  final double maxHeight;
  final Widget child;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return SizedBox.expand(
      child: child,
    );
  }

  //展开状态下的高度
  @override
  double get maxExtent => max(maxHeight, minHeight);

  //收起状态下的高度
  @override
  double get minExtent => minHeight;

  @override
  bool shouldRebuild(CommonSliverPersistentHeaderDelegate oldDelegate) {
    return maxHeight != oldDelegate.maxExtent ||
        minHeight != oldDelegate.minExtent ||
        child != oldDelegate.child;
  }
}
