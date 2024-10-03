import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'provider/provider.dart';
import 'routes/routes.dart';
import 'view/splash/splash_screen.dart';

void main() {
  runApp(
    MultiProvider(
      providers: providers,
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Iaaxin Task',
      debugShowCheckedModeBanner: false,
      routes: routes,
      initialRoute: SplashScreen.routeName,
    );
  }
}
