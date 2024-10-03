// ignore_for_file: prefer_final_fields

import 'package:flutter/material.dart';
import 'package:iaaxin_task/controller/news_controller.dart';
import 'package:iaaxin_task/model/news_model.dart';

class NewsProvider with ChangeNotifier {
  List<NewsModel> _news = [];
  bool _isLoading = false;
  String _error = '';

  List<NewsModel> get news => _news;
  bool get isLoading => _isLoading;
  String get error => _error;

  NewsController newsController = NewsController();

  Future<void> fetchNews() async {
    _isLoading = true;
    _error = '';
    notifyListeners();

    try {
      _news = await newsController.getNews();
    } catch (e) {
      _error = 'Failed to fetch News';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
