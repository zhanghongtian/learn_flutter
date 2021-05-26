import 'dart:io';
import 'package:dio/dio.dart';
import 'dart:async';

Future requestJson(url, {data}) async {
  try {
    Response response;
    Dio dio = Dio();
    dio.options.contentType = ContentType.json.value;
    response = await dio.post(url, data: data);
    if (response.statusCode == 200) {
      return response;
    } else {
      throw Exception('后端接口异常');
    }
  } catch (e) {
    return print('error:::${e}');
  }
}

void main(List<String> args) {
  requestJson('http://39.107.155.171:7767/news-pai/addNews', data: {
    "title": "aaaaaa",
    "description": "aaaaaa",
    "score": "1",
    "imageUrl": "1",
    "isFavorite": "1",
    "userName": "hjaahah"
  }).then((value) => print(value));
}
