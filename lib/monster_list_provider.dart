import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'globals.dart';
import 'package:http/http.dart' as http;
import 'monster_list_model.dart';

class GetMonsterList with ChangeNotifier {

  MonsterList monsters = MonsterList.empty();

  Future getMonsters() async {
    print(apiUrl + monsterlistUrl);
    var response = await http.get(Uri.parse(apiUrl + monsterlistUrl));
    try {
      monsters = monsterListFromJson(response.body);
    } on Exception catch (e) {
      debugPrint(e.toString());
    }
    debugPrint('Amount of monsters: ${monsters.count}');

    notifyListeners();
  }
}
