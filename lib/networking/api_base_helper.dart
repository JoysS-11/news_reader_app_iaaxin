// ignore_for_file: avoid_print

import 'package:http/http.dart' as http;

class ApiBaseHelper {
  Future<dynamic> get(String url) async {
    print('Api Get, url  $url');
    try {
      final response = await http.get(
        Uri.parse(
          url,
        ),
      );
      return responseStatuscode(response);
    } catch (e) {
      // Handle any exceptions thrown during the request
      print('Error: $e');
    }
  }
}

dynamic responseStatuscode(http.Response response) {
  switch (response.statusCode) {
    case 200:
      print(
          "statusCode : ${response.statusCode} OK - the request was successful and the server has returned data as requested.");
      return response;
    case 201:
      print(
          "statusCode : ${response.statusCode} Created - the request was successful and a new resource has been created.");
      return response;
    case 400:
      print(
          " statusCode : ${response.statusCode} Bad Request - the request was malformed or invalid.");
      return response;
    case 401:
      print(
          "statusCode : ${response.statusCode} Unauthorized - the request requires authentication or authorization.");
      return response;
    case 404:
      print(
          "statusCode : ${response.statusCode} Not Found - the requested resource could not be found on the server.");
      return response;
    case 500:
      print("statusCode : ${response.statusCode} Internal Server Error");
      return response;
  }
}
