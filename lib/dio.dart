import 'dart:typed_data';

import 'package:charset_converter/charset_converter.dart';
import 'package:dio/dio.dart';

final dio = Dio(BaseOptions(responseType: ResponseType.bytes))
  ..interceptors.add(InterceptorsWrapper(onResponse: (response) async {
    response.data = await CharsetConverter.decode(
        "EUC-KR", Uint8List.fromList(response.data));
    return response;
  }));
