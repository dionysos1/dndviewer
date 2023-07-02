import 'dart:convert';
import 'package:dndviewer/monster_list_model.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'globals.dart';

class FavoriteController with ChangeNotifier {
  List<Result> favorites = globalFavorites;

  Future<bool> setFavorite({required Result itemToAdd}) async {
    favorites.add(itemToAdd);

    notifyListeners();
    return favoListToStringList();
  }

  getFavorites() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? favoritesFromLocalStorage = prefs.getStringList('favorites');

    favorites = [];

    if (favoritesFromLocalStorage != null) {
      for (var i in favoritesFromLocalStorage) {
        favorites.add(Result.fromJson(json.decode(i)));
      }
    }
    globalFavorites = favorites;

    notifyListeners();
  }

  removeFavorite({required Result itemToRemove}) async {
    favorites.removeWhere((result) => result == itemToRemove);

    notifyListeners();
    return favoListToStringList();
  }

  Future<bool> favoListToStringList() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    List<String> favoString = [];

    for (Result i in favorites) {
      favoString.add(jsonEncode(i.toJson()));
    }

    try {
      await prefs.setStringList("favorites", favoString);
      notifyListeners();
      return true;
    } catch (e) {
      debugPrint(e.toString());
      return false;
    }
  }
}
