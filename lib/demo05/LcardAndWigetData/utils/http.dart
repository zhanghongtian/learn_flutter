import 'dart:convert';

import 'package:dio/dio.dart';
import 'dart:async';

Future<Response> postJson(url, {data}) async {
  try {
    Dio dio = Dio();
    // dio.options.contentType = ContentType.json.value;
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


class CommonBean{
  int code;
  List<NewsModel> data;

  CommonBean({this.code, this.data});

  factory CommonBean.from(Map<String, dynamic> parsedJson){
    return CommonBean(
      code:parsedJson['code'],
      data: (parsedJson['data'] as List).map((e) => NewsModel.fromJson(e)).toList(),
    );
  }
}

class NewsModel {
  final String id;
  final String title;
  final String description;
  final double score;
  final String imageUrl;
  final bool isFavorite; // 是否收藏
  final String userName;

  NewsModel({ this.title,
    this.id,
    this.description,
    this.score,
    this.imageUrl,
    this.isFavorite = false,
    this.userName}); // 命名参数的构造器，required修饰的参数代表是必填的

  factory NewsModel.fromJson(Map<String, dynamic> parsedJson) {
    return NewsModel(
        id: parsedJson['id'],
        title: parsedJson['title'],
        description: parsedJson['description'],
        score: parsedJson['score'],
        imageUrl: parsedJson['imageUrl'],
        isFavorite: parsedJson['isFavorite'],
        userName: parsedJson['userName']);
  }
}
void main(List<String> args) {
  // postJson('http://39.107.155.171:7767/news-pai/addNews', data: {
  //   "title": "aaaaaa",
  //   "description": "aaaaaa",
  //   "score": "1",
  //   "imageUrl": "1",
  //   "isFavorite": "1",
  //   "userName": "hjaahah"
  // }).then((value) => print(value));

  getRequest('http://39.107.155.171:7767/news-pai/allNewsList').then((response){
    var data = json.decode(response.toString());
    print(data.runtimeType);
    CommonBean commonBean= CommonBean.from(data);
    print(commonBean.data[0].imageUrl);
    // print(response);
  } );

}
