library globals;

import 'package:dndviewer/favo_helper.dart';
import 'package:dndviewer/monster_list_model.dart';

String apiUrl = 'https://www.dnd5eapi.co';
String monsterlistUrl = '/api/monsters';

FavoriteController favos = FavoriteController();

List<Result> globalFavorites = [];