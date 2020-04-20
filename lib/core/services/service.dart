import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

class ApiService {
  // next three lines makes this class a Singleton
  static ApiService _instance = new ApiService.internal();
  ApiService.internal();
  factory ApiService() => _instance;
  HttpClient httpClient = new HttpClient();
  final JsonDecoder _decoder = new JsonDecoder();

  Future<dynamic> post(String url, {Map headers, body, encoding}) {
    print(body);
    return http
        .post(url, body: body, headers: headers, encoding: encoding)
        .then((http.Response response) {
      debugPrint('Hola post response');
      print(response);
      final String res = response.body;
      final int statusCode = response.statusCode;

      if (statusCode == 404) {
        print(res);
        throw statusCode;
      }

      if (statusCode < 200 || statusCode >= 400 || json == null) {
        print(res);
        throw statusCode;
      }
      return _decoder.convert(res);
    });
  }
}
