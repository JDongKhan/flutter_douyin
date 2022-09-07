import 'package:get/get.dart';

import '../utils/logger_util.dart';
import 'base_controller.dart';

/// 通用的，都可以用
abstract class BaseCommonController<T> extends BaseController {
  BaseCommonController({
    super.autoUpdate = true,
    super.immediatelyInit = true,
  });

  // ignore: prefer_typing_uninitialized_variables
  final Rx<T?> _data = Rx(null);
  T? get data => _data.value;
  set data(value) {
    _data.value = value;
    if (value == null || isEmpty(value)) {
      setNoData();
    } else {
      setSuccess();
    }
  }

  @override
  Future<T?> initData() {
    setLoading();
    return loadData().then((value) {
      T v = value;
      data = value;
      return v;
    }).catchError((error, stackTrace) {
      logger.w('${error.toString()}\n${stackTrace.toString()}');
      setFailed(error);
    });
  }

  void refreshState() {
    _data.refresh();
  }
}
