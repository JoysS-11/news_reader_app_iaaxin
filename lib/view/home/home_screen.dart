// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:iaaxin_task/controller/internet_check.dart';
import 'package:iaaxin_task/provider/news_provider.dart';
import 'package:iaaxin_task/view/news/news_screen.dart';
import 'package:provider/provider.dart';

import '../../constants/app_colors.dart';
import '../../model/news_model.dart';
import '../../networking/local_storage.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key, this.isInternetConnected});

  final bool? isInternetConnected;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<NewsModel> news = [];
  List<NewsModel> localnews = [];
  bool? internetCheck;
  bool show = false;
  InternetCheck internetChecker = InternetCheck();

  @override
  void initState() {
    super.initState();
    getData();
  }

  getData() async {
    setState(() {
      internetCheck = widget.isInternetConnected;
    });
    if (internetCheck == true) {
      await LocalStorage.removeLocalNews(context);
      Future.microtask(
          () => Provider.of<NewsProvider>(context, listen: false).fetchNews());
    } else {
      var localnews = await LocalStorage.getLocalNews();

      setState(() {
        this.localnews = localnews!;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final newsProvider = Provider.of<NewsProvider>(context);
    news = newsProvider.news;
    Future.delayed(const Duration(seconds: 2), () {
      if (!mounted) return;
      setState(() {
        show = true;
      });
    });
    addLocalStorage(newsProvider.news);
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        systemOverlayStyle: const SystemUiOverlayStyle(
          // Status bar color
          statusBarColor: AppColors.white,
          // Status bar brightness (optional)
          statusBarIconBrightness: Brightness.dark, // For Android (dark icons)
          statusBarBrightness: Brightness.light, // For iOS (dark icons)
        ),
        toolbarHeight: 0,
      ),
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              color: AppColors.white,
              width: double.infinity,
              child: Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: size.height * 0.025,
                    vertical: size.height * 0.015),
                child: Text(
                  "News",
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: size.height * 0.02,
                    color: AppColors.black,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
            Expanded(
              child: internetCheck == true
                  ? show == true
                      ? news.isNotEmpty
                          ? NewsScreen(news: news)
                          : errorMessage(
                              "Something went wrong for loading news!...",
                              Icons.error_rounded,
                            )
                      : pleaseWait()
                  : show == true
                      ? localnews.isNotEmpty
                          ? NewsScreen(
                              news: localnews,
                              isLocalNews: true,
                            )
                          : errorMessage(
                              "Ther is no saved news!...",
                              Icons.cancel_outlined,
                            )
                      : pleaseWait(),
            ),
            internetCheck != true
                ? Container(
                    width: double.infinity,
                    color: AppColors.white,
                    child: Column(
                      children: [
                        SizedBox(height: size.height * 0.02),
                        TextButton.icon(
                          onPressed: () {
                            refresh();
                          },
                          label: Icon(
                            Icons.refresh_rounded,
                            size: size.height * 0.03,
                            color: AppColors.black,
                          ),
                        ),
                        SizedBox(height: size.height * 0.01),
                        Text(
                          "Please check you internet connection!...",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: size.height * 0.014,
                            color: AppColors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: size.height * 0.02),
                      ],
                    ),
                  )
                : const SizedBox(),
          ],
        ),
      ),
    );
  }

  Center errorMessage(String text, IconData icon) {
    Size size = MediaQuery.of(context).size;
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            size: size.height * 0.05,
            color: AppColors.black,
          ),
          SizedBox(height: size.height * 0.01),
          Text(
            text,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: size.height * 0.014,
              color: AppColors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Center pleaseWait() {
    Size size = MediaQuery.of(context).size;
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const CircularProgressIndicator(color: AppColors.black),
          SizedBox(height: size.height * 0.01),
          Text(
            "Please wait!...",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: size.height * 0.014,
              color: AppColors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  addLocalStorage(List<NewsModel> localnews) async {
    if (internetCheck == true) {
      await LocalStorage.setLocalNews(localnews);
    }
  }

  refresh() async {
    setState(() {
      show = false;
    });
    var internet = await internetChecker.checkInternetConnection();
    Navigator.pushReplacement(
      context,
      PageRouteBuilder(
        pageBuilder: (a, b, c) => HomeScreen(isInternetConnected: internet),
        transitionDuration: const Duration(seconds: 0),
      ),
    );
  }
}
