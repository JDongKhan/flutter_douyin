import 'package:get/get.dart';

import '../utils/logger_util.dart';
import 'base_controller.dart';

/// 列表controller，专门为list实现
abstract class BaseListController<E> extends BaseController {
  BaseListController({
    super.autoUpdate = true,
    super.immediatelyInit = true,
  });
  // ignore: prefer_typing_uninitialized_variables
  final RxList<E> _data = <E>[].obs;
  // ignore: invalid_use_of_protected_member
  List<E> get data => _data.value;
  set data(value) {
    _data.value = value;
    if (isEmpty(value)) {
      setNoData();
    } else {
      setSuccess();
    }
  }

  ///添加单条数据
  void add(E e) {
    _data.add(e);
  }

  ///添加整个列表数据
  void addAll(List<E>? list) {
    if (list == null) return;
    _data.addAll(list);
  }

  ///删除单条数据
  void remove(E e) {
    _data.remove(e);
  }

  ///清理数据
  void clear() {
    _data.clear();
  }

  @override
  Future<List<E>?> initData() {
    setLoading();
    return loadData().then((value) {
      List<E> v = <E>[];
      if (value is List<E>) {
        _data.addAll(value);
        v = value;
      }
      if (isEmpty(value)) {
        setNoData();
      } else {
        setSuccess();
      }
      return v;
    }).catchError((error, stackTrace) {
      logger.w('${error.toString()}\n${stackTrace.toString()}');
      setFailed(error);
    });
  }

  @override
  bool isEmpty(dynamic data) => _data.isEmpty;
}
