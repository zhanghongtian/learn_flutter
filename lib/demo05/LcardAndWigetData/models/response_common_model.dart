import 'news_model.dart';

class ResponseCommonBean{
  int code;
  List<NewsModel> data;

  ResponseCommonBean({this.code, this.data});

  factory ResponseCommonBean.from(Map<String, dynamic> parsedJson){
    return ResponseCommonBean(
      code:parsedJson['code'],
      data: (parsedJson['data'] as List).map((e) => NewsModel.fromJson(e)).toList(),
    );
  }
}