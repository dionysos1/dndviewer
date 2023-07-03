import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../globals.dart';
import '../models/monster_list_model.dart';
import '../models/monster_model.dart';

class CustomMonsterController with ChangeNotifier {
  List<Monster> customMonsters = globalCustomMonsters;

  Future<bool> setCustomMonster({required Monster itemToAdd}) async {
    customMonsters.add(itemToAdd);

    notifyListeners();
    return customMonstersToStringList();
  }

  getCustomMonsters() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? customMonstersFromLocalStorage = prefs.getStringList('customMonsters');

    customMonsters = [];

    if (customMonstersFromLocalStorage != null) {
      for (var i in customMonstersFromLocalStorage) {
        customMonsters.add(Monster.fromJson(json.decode(i)));
      }
    }
    globalCustomMonsters = customMonsters;
    List<Result> tempList = [];
    for (Monster i in customMonsters) {
      int index = customMonsters.indexOf(i);
      tempList.add(Result(index: i.index, name: i.name, url: 'local: $index'));
    }
    globalCustomMonsterList = tempList;

    notifyListeners();
  }

  removeMonster({required Monster itemToRemove}) async {
    customMonsters.removeWhere((result) => result == itemToRemove);

    notifyListeners();
    return customMonstersToStringList();
  }

  Future<bool> customMonstersToStringList() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    List<String> customMonsterString = [];

    for (Monster i in customMonsters) {
      customMonsterString.add(jsonEncode(i.toJson()));
    }

    try {
      await prefs.setStringList("customMonsters", customMonsterString);
      notifyListeners();
      return true;
    } catch (e) {
      debugPrint(e.toString());
      return false;
    }
  }
}
