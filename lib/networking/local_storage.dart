import 'dart:convert';
import 'dart:ui';

import 'package:shared_preferences/shared_preferences.dart';

import '../model/news_model.dart';

final Future<SharedPreferences> _storage = SharedPreferences.getInstance();

class LocalStorage {
  static Future<VoidCallback?> setLocalNews(
    List<NewsModel> news,
  ) async {
    final SharedPreferences storage = await _storage;
    List<String> cacheStrings = news.map((e) {
      return jsonEncode(e.toJson());
    }).toList();
    await storage.setStringList("local_news", cacheStrings);
    return null;
  }

  static Future<List<NewsModel>?> getLocalNews() async {
    final SharedPreferences storage = await _storage;
    var data = storage.getStringList('local_news');
    if (data == null) {
      return null;
    } else {
      List<NewsModel> news = data.map((e) {
        return NewsModel.fromJson(jsonDecode(e));
      }).toList();
      return news;
    }
  }

  static Future<VoidCallback?> removeLocalNews(context) async {
    final SharedPreferences storage = await _storage;
    await storage.remove("local_news");
    return null;
  }
}
