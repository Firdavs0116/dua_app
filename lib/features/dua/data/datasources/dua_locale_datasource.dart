import 'dart:convert';

import 'package:my_dua_app/features/dua/data/models/dua_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class  DuaLocaleDatasource {
  Future<void> cacheDuas(List<DuaModel> duas);
  Future<List<DuaModel>> getCachedDuas();
}

class DuaLocaleDatasourceImpl extends DuaLocaleDatasource{

  final SharedPreferences  prefs;
  static const _key = "cashed duas";
  DuaLocaleDatasourceImpl({
    required this.prefs
  });


  @override
  Future<void> cacheDuas(List<DuaModel> duas) async {
    final jsonList = duas.map((dua) => dua.toJson()).toList();
    await  prefs.setString(_key, jsonEncode(jsonList));
  }

  @override
  Future<List<DuaModel>> getCachedDuas() async {
    final jsonString = prefs.getString(_key);
    if(jsonString == null ) return [];
    final decoded = jsonDecode(jsonString) as List;
    return decoded.map((e) => DuaModel.fromJson(e, e["id"])).toList();
  }

}