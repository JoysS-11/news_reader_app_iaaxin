// ignore_for_file: use_build_context_synchronously

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:iaaxin_task/controller/internet_check.dart';

import '../../constants/app_colors.dart';
import '../../routes/route_name.dart';
import '../home/home_screen.dart';
import '../widgets/slide_fade_transition.dart';

class SplashScreen extends StatefulWidget {
  static const String routeName = RouteNames.splash;
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  Timer? timer;
  bool isInternetConnected = false;
  InternetCheck internetChecker = InternetCheck();

  @override
  void initState() {
    super.initState();
    internetCheck();
    Future.delayed(const Duration(seconds: 3), () {
      gotoHomeScreen();
    });
  }

  internetCheck() async {
    var internet = await internetChecker.checkInternetConnection();

    setState(() {
      isInternetConnected = internet;
    });
  }

  void gotoHomeScreen() async {
    setState(() {});

    timer = Timer(const Duration(), () {
      Navigator.pushAndRemoveUntil(
        context,
        _createRoute(),
        (route) => false,
      );
    });
  }

  Route _createRoute() {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => HomeScreen(
        isInternetConnected: isInternetConnected,
      ),
      transitionDuration: const Duration(microseconds: 7000),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(0.0, 1.0);
        const end = Offset.zero;
        const curve = Curves.ease;
        var tween =
            Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
        return SlideTransition(
          position: animation.drive(tween),
          child: child,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
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
        child: Center(
          child: SlideFadeTransition(
            delayStart: const Duration(seconds: 1),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: size.height / 2,
                  child: Image.asset(
                    "assets/images/logo.jpeg",
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
