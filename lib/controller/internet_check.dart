// ignore_for_file: avoid_print

import 'dart:io';

class InternetCheck {
  Future<bool> checkInternetConnection() async {
    bool isInternetConnected = false;
    try {
      final result = await InternetAddress.lookup('google.com');
      print("result $result");
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        isInternetConnected = true;
        print("Connected to the Internet");
      } else {
        isInternetConnected = false;
        print("No Internet Connection");
      }
    } on SocketException catch (_) {
      isInternetConnected = false;
      print("No Internet Connection");
    }

    return isInternetConnected;
  }
}
