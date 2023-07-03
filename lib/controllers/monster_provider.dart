
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import '../globals.dart';
import '../models/monster_model.dart';
import 'package:http/http.dart' as http;

class GetMonster with ChangeNotifier {

  Monster monster = Monster.empty();

  Future getMonsterInfo(String url) async {
    monster = Monster.empty();
    if (url.contains('local: ')){

      monster = globalCustomMonsters[int.parse(url.replaceFirst('local: ', ''))];
    } else {
      var response = await http.get(Uri.parse(apiUrl + url));
      print(apiUrl + url);
      try {
        monster = monsterFromJson(response.body);
      } on Exception catch (e) {
        debugPrint(e.toString());
      }
    }
    debugPrint('monster name: ${monster.name}');

    WidgetsBinding.instance.addPostFrameCallback((_) {
      notifyListeners();
    });
    }
}


