import 'package:flutter/cupertino.dart';
import 'package:hive/hive.dart';
import 'package:vecinapp/core/models/apartment.dart';
import 'package:vecinapp/core/models/community.dart';
import 'package:vecinapp/core/services/service.dart';

class CommunityService {
  ApiService _netUtil = new ApiService();
  static final BASE_URL = "https://vecindapp-server.herokuapp.com";

  Future<List<Community>> getCommunitiesByUser() async{
    var tokenBox = Hive.box('user');
    var token = tokenBox.get('token');
    return _netUtil.get(
        BASE_URL + "/api/comunidadesByUser/",
        token
    ).then((dynamic res) {
      var list = res.map<Community>((json) => Community.fromJson(json)).toList();
      return list;
    });
  }

  Future<List<Apartment>> getApartmentsByUser() async{
    var tokenBox = Hive.box('user');
    var token = tokenBox.get('token');
    return _netUtil.get(
        BASE_URL + "/api/viviendasByUser/",
        token
    ).then((dynamic res) {
      debugPrint('getApartmentsByUser');
      print(res);
      var list = res.map<Apartment>((json) => Apartment.fromJson(json)).toList();
      debugPrint('list');
      print(list);
      return list;
    });
  }

  Future<Apartment> getApartmentByPk(pk) async {
    var tokenBox = Hive.box('user');
    var token = tokenBox.get('token');
    return _netUtil.get(
        BASE_URL + "/api/vivienda/" + pk,
        token
    ).then((dynamic res) {
      debugPrint('getApartmentByPk');
      print(res);
//      var list = res.map<Apartment>((json) => Apartment.fromJson(json)).toList();
//      debugPrint('list');
//      print(list);
      return Apartment.fromJson(res);
    });
  }
}