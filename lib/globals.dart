library globals;

import 'dart:async';

import 'package:dndviewer/misc/custom_monster_helper.dart';
import 'package:dndviewer/misc/favo_helper.dart';
import 'package:dndviewer/models/monster_list_model.dart';



import 'models/monster_model.dart';

String apiUrl = 'https://www.dnd5eapi.co';
String monsterlistUrl = '/api/monsters';

FavoriteController favos = FavoriteController();
CustomMonsterController customMonsterController = CustomMonsterController();

List<Result> globalFavorites = [];
List<Monster> globalCustomMonsters = [];
List<Result> globalCustomMonsterList = [];

extension StringExtension on String {
  String replaceSpacesWithDashes() {
    return replaceAll(' ', '-');
  }
}

/// new monster
Monster customMonster = Monster.empty();