// ignore_for_file: avoid_print

import 'dart:convert';

import 'package:iaaxin_task/model/news_model.dart';

import '../config/api_config.dart';
import '../networking/api_base_helper.dart';

class NewsController {
  ApiBaseHelper helper = ApiBaseHelper();

  Future<List<NewsModel>> getNews() async {
    try {
      final response = await helper.get(
          "${ApiConfig.baseUrl}?q=${ApiConfig.newsTopic}&from=2024-09-25&sortBy=publishedAt&apiKey=${ApiConfig.newsApiKey}");
      var value = json.decode(response.body);
      List data = value["articles"];
      List<NewsModel> result = data.map((e) => NewsModel.fromMap(e)).toList();
      return result;
    } catch (err, stackTrace) {
      print('$err:::$stackTrace');
      throw stackTrace;
    }
  }
}
