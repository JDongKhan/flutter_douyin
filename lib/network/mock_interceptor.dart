import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:path/path.dart' as path;

import '../utils/asset_bundle_utils.dart';

/// @author jd

class NetworkMockInterceptor extends Interceptor {
  @override
  void onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    if (options.extra['mock'] == true) {
      final String jsonPath =
          'assets/jsons/${path.basenameWithoutExtension(options.path)}.json';
      final String jsonString = await AssetBundleUtils.loadString(jsonPath);
      dynamic json = jsonDecode(jsonString);
      await Future<dynamic>.delayed(const Duration(milliseconds: 1000));
      handler.resolve(Response(
        requestOptions: options,
        data: json,
        headers: Headers(),
        extra: options.extra,
        statusCode: 200,
      ));
      return;
    }
    handler.next(options);
  }
}
