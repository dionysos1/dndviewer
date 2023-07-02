
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'globals.dart';
import 'monster_model.dart';
import 'package:http/http.dart' as http;

class GetMonster with ChangeNotifier {

  Monster monster = Monster.empty();

  Future getMonsterInfo(url) async {
    monster = Monster.empty();
    var response = await http.get(Uri.parse(apiUrl + url));
    print(apiUrl + url);
    try {
      monster = monsterFromJson(response.body);
    } on Exception catch (e) {
      debugPrint(e.toString());
    }
    debugPrint('monster name: ${monster.name}');

    notifyListeners();
    }
}


