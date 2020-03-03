import 'dart:typed_data';

import 'package:charset_converter/charset_converter.dart';
import 'package:dio/dio.dart';

class DioProvider {
  static DioProvider _instance;

  factory DioProvider() => _instance ?? (_instance = DioProvider._());

  final _dio = Dio();

  DioProvider._() {
    _dio.options.responseType = ResponseType.bytes;
  }

  Future<String> get(String url) async {
    final response = await _dio.get(url);
    final data = await CharsetConverter.decode(
        "EUC-KR", Uint8List.fromList(response.data));

    return data;
  }
}
