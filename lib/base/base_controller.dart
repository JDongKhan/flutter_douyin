import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../network/app_exceptions.dart';

///@author JD

/// 请不要直接使用此类，可使用其子类

enum LoadingStatus {
  ///空闲
  idle,

  ///加载
  loading,

  ///成功
  success,

  ///失败
  failed,

  ///无数据
  noData,
}

abstract class BaseController extends GetxController {
  BaseController({
    this.autoUpdate = true,
    this.immediatelyInit = true,
  });

  ///是否手动更新widget，适用于GetXBuilder，因为它不会主动刷新
  final bool autoUpdate;

  ///立即执行 initData
  final bool immediatelyInit;

  ///状态，默认空闲
  final _loadingStatus = LoadingStatus.idle.obs;
  LoadingStatus get loadingStatus => _loadingStatus.value;

  ///加载错误后的错误信息
  String? error;

  @override
  void onReady() {
    super.onReady();
    if (immediatelyInit) {
      initData();
    }
  }

  ///初始化数据
  Future<dynamic> initData();

  ///加载中
  void setLoading() {
    _loadingStatus.value = LoadingStatus.loading;
    debugPrint('开始加载数据...');
    if (autoUpdate) update();
  }

  ///成功
  void setSuccess() {
    _loadingStatus.value = LoadingStatus.success;
    debugPrint('页面加载成功...');
    if (autoUpdate) update();
  }

  ///失败
  void setFailed(dynamic onError) {
    _loadingStatus.value = LoadingStatus.failed;
    if (onError is DioError) {
      error = onError.error.toString();
    } else if (onError is AppException) {
      error = onError.toString();
    } else {
      if (kReleaseMode) {
        error = AppException.unknownError;
      } else {
        error = onError.toString();
      }
    }
    debugPrint('页面加载失败...');
    if (autoUpdate) update();
  }

  ///无数据
  void setNoData() {
    _loadingStatus.value = LoadingStatus.noData;
    debugPrint('页面没有数据...');
    if (autoUpdate) update();
  }

  ///是否为空
  bool isEmpty(dynamic data) => false;

  ///加载数据
  Future<dynamic> loadData();
}
