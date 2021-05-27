import 'package:dio/dio.dart';
import 'dart:io';
import 'dart:convert';

import 'package:flutter_app2/demo05/LcardAndWigetData/models/news_model.dart';

class HttpUtils {
  static const String BaseUrl = "https://www.wanandroid.com/";
  static const String FormatUrl = "json";
  static const String Articles = "article/list/";
  static const String Projects = "project/list/";
  static const String Banner = "banner/";
  static const String ProjectTree= "project/tree/";
  static const String Wxarticle = "wxarticle/chapters/";

  static const String GET = 'GET';
  static const String POST = 'POST';
  static const int TIMEOUT_CONNECT = 15000;
  static const int TIMEOUT_RECEIVE = 15000;
  static const int TIMEOUT_SEND = 15000;

  static getUrl({String article, int index}) {
    if (index != null) {
      return BaseUrl + article + "$index/" + FormatUrl;
    } else {
      return BaseUrl + article + FormatUrl;
    }
  }
}

class HttpController {
  /**
   * get 请求
   */
  static getData(String url, Function successCallback,
      {Map<String, String> params, Function errorCallBack}) async {
    if (params != null && params.isNotEmpty) {
      StringBuffer stringBuffer = new StringBuffer("?");
      params.forEach((key, value) {
        stringBuffer.write("$key" + "=" + "$value" + "&");
      });
      String paramStr = stringBuffer.toString();
      paramStr = paramStr.substring(0, paramStr.length - 1);
      url += paramStr;
    }
    _request(url, successCallback,
        method: HttpUtils.GET, params: params, errorCallBack: errorCallBack);
  }

  /**
   * Post请求
   */
  static postData(String url, Function successCallback,
      {Map<String, String> params, Function errorCallBack}) async {
    _request(url, successCallback,
        method: HttpUtils.POST, params: params, errorCallBack: errorCallBack);
  }

  /**
   * 请求数据
   */
  static void _request(String url, Function successCallback,
      {String method,
        Map<String, String> params,
        Function errorCallBack}) async {
    print("url = $url");
    String errorMsg = "";
    int statusCode;
    try {
      Response response;
      BaseOptions baseOptions = new BaseOptions(
        connectTimeout: HttpUtils.TIMEOUT_CONNECT,
        receiveTimeout: HttpUtils.TIMEOUT_RECEIVE,
      );
      // dio库中默认将请求数据序列化为json，此处可根据后台情况自行修改
//      contentType:new ContentType('application', 'x-www-form-urlencoded',charset: 'utf-8')
      Options options = new Options(
        receiveTimeout: HttpUtils.TIMEOUT_RECEIVE,
        sendTimeout: HttpUtils.TIMEOUT_SEND,
        // contentType: ContentType.json.value,
      );
      Dio dio = new Dio(baseOptions);
      if (method == HttpUtils.GET) {
        response =
        await dio.get(url, queryParameters: params, options: options);
      } else {
        response =
        await dio.post(url, data: params, options: options);
      }
      statusCode = response.statusCode;
      if (statusCode != HttpStatus.ok) {
        errorMsg = "网络请求错误,状态码:" + statusCode.toString();
        _handError(errorCallBack, errorMsg);
      } else {
        if (successCallback != null) {
          var data = json.decode(response.toString()); //对数据进行Json转化
          successCallback(data);
          print("data = " + data);
        }
      }
    } catch (exception) {
      _handError(errorCallBack, exception.toString());
    }
  }

  /**
   * 异常处理
   */
  static void _handError(Function errorCallback, String errorMsg) {
    if (errorCallback != null) {
      errorCallback(errorMsg);
    }
  }
}

class RequestBean{
  int code;
  List<NewsModel> data;

  RequestBean({this.code, this.data});

  factory RequestBean.from(Map<String, dynamic> parsedJson){
    return RequestBean(
      code:parsedJson['code'],
      data: (parsedJson['data'] as List).map((e) => NewsModel.fromJson(e)).toList(),
    );
  }
}

void main(){
  // HttpController.postData("http://39.107.155.171:7767/news-pai/addNews", (data){
  //   print(data);
  //   print(data.runtimeType);
  // },params:{
  //   "title": "aaaaaa",
  //   "description": "aaaaaa",
  //   "score": "1",
  //   "imageUrl": "1",
  //   "isFavorite": "1",
  //   "userName": "hjaahah"
  // });
  HttpController.getData("http://39.107.155.171:7767/news-pai/allNewsList", (data){
    print(data);
    print(data.runtimeType);
    // RequestBean.from(data);
  });
}