import 'dart:async';
import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:vecinapp/core/models/users.dart';
import 'package:vecinapp/core/services/service.dart';


class LoginUser {
  ApiService _netUtil = new ApiService();
  static final BASE_URL = "https://vecindapp-server.herokuapp.com";

  Future<User> login(email, password) async{
    debugPrint(email + password);
    var body = {
        "email" : email,
        "password" : password
    };
    await new Future.delayed(const Duration(seconds: 3));
    return _netUtil.post(BASE_URL + "/api/auth/login", body: body).then((dynamic res) {

      if(res["non_field_errors"] != null) throw new Exception(res["non_field_errors"]);
      return new User.map(res);
    });
  }

  Future<User> register(email, password) {
    var body = {
      "email" : email,
      "password" : password
    };
    return _netUtil.post(BASE_URL + "/api/auth/register", body: body).then((dynamic res) {
      debugPrint('response register');
      print(res);
      if(res["non_field_errors"] != null) throw new Exception(res["non_field_errors"]);
      return new User.map(res);
    });
  }
}

class HomeService {
  ApiService _netUtil = new ApiService();
  static final BASE_URL = "https://vecindapp-server.herokuapp.com";
  static final LOGIN_URL = BASE_URL + "/api/auth/";
//  static final _API_KEY = "somerandomkey";


  Future<User> login(email) async {
    await new Future.delayed(const Duration(seconds: 3));
    User user = new User(email: email);
    return _netUtil.post(LOGIN_URL, body: user.toJson())
        .then((dynamic res) {
      print(res);
      if(res["detail"] == 'Not Found') throw new Exception(res["detail"]);
      return new User.map(res);
    })
    ;
  }
}