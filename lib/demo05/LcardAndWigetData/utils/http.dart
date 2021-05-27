import 'dart:io';
import 'package:dio/dio.dart';
import 'dart:async';

Future<Response> postJson(url, {data}) async {
  try {
    Dio dio = Dio();
    dio.options.contentType = ContentType.json.value;
    Response response = await dio.post(url, data: data);
    if (response.statusCode == 200) {
      return response;
    } else {
      throw Exception('后端接口异常');
    }
  } catch (e) {
    print('error:::$e');
    return null;
  }
}

Future<Response> postForm(url, {data}) async {
  try {
    Dio dio = Dio();
    Response response = await dio.post(url, data: data);
    if (response.statusCode == 200) {
      return response;
    } else {
      throw Exception('后端接口异常');
    }
  } catch (e) {
    print('error:::$e');
    return null;
  }
}

Future<Response> getRequest(url, {data}) async {
  try {
    Dio dio = Dio();
    Response response = await dio.get(url, queryParameters: data);
    if (response.statusCode == 200) {
      return response;
    } else {
      throw Exception('后端接口异常');
    }
  } catch (e) {
    print('error:::$e');
    return null;
  }
}

void main(List<String> args) {
  postJson('http://39.107.155.171:7767/news-pai/addNews', data: {
    "title": "aaaaaa",
    "description": "aaaaaa",
    "score": "1",
    "imageUrl": "1",
    "isFavorite": "1",
    "userName": "hjaahah"
  }).then((value) => print(value));
}
