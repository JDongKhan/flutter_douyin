import 'package:flutter/material.dart';
import 'package:flutter_douyin/utils/asset_bundle_utils.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import '../../../utils/navigation_util.dart';
import '../../people_detail/page/doiyin_people_detail_page.dart';

/// @author jd
///同城

class DouyinHomeCityPage extends StatefulWidget {
  @override
  _DouyinHomeCityPageState createState() => _DouyinHomeCityPageState();
}

class _DouyinHomeCityPageState extends State<DouyinHomeCityPage> {
  final List<String> _list = [
    'video_0',
    'video_1',
    'video_2',
    'video_3',
    'video_4',
    'video_5',
    'video_6',
    'video_7',
    'video_8',
    'video_9',
    'video_10',
    'video_11',
    'video_12',
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        top: kToolbarHeight + MediaQuery.of(context).padding.top,
      ),
      child: MasonryGridView.count(
        crossAxisCount: 2,
        mainAxisSpacing: 2.0,
        itemCount: _list.length * 2,
        crossAxisSpacing: 2.0,
        itemBuilder: (BuildContext context, int index) {
          return _buildItem(index);
        },
      ),
    );
  }

  Widget _buildItem(int index) {
    return GestureDetector(
      onTap: () {
        NavigationUtil.push(DouyinPeopleDetailPage());
      },
      child: Image.asset(
        AssetBundleUtils.getImgPath(_list[index % _list.length]),
      ),
    );
  }
}
