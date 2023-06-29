import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'monsterModel.dart';

class getData with ChangeNotifier {

  List<Monsters> monsters = [];
  String test = 'test';

  Future getMonsters() async {
    final String monsterJson = await rootBundle.loadString('assets/json/monsters.json');
    try {
      monsters = monstersFromJson(monsterJson);
    } on Exception catch (e) {
      print(e);
    }
    print('Amount of monsters: ' + monsters.length.toString());

    notifyListeners();
    }
}


