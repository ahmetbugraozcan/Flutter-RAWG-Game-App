import 'dart:convert';
import 'package:appcentflutterassignment/core/constants/enums/preferences_enums.dart';
import 'package:appcentflutterassignment/core/init/cache/cache_manager.dart';
import 'package:appcentflutterassignment/models/game_detail_model.dart';
import 'package:flutter/material.dart';

class FavoritesProvider extends ChangeNotifier {
  CacheManager cacheManager = CacheManager.instance;
  bool isLoading = false;

  FavoritesProvider() {
    getFavoritesFromCache();
  }
  List<GameDetailModel> favorites = [];

  getFavoritesFromCache() async {
    String? rawJson =
        CacheManager.instance.getStringValue(PreferencesEnums.FAVORITES);
    if (rawJson != null) {
      List<dynamic> map = jsonDecode(rawJson);
      for (var value in map) {
        favorites.add(GameDetailModel.fromJson(value));
      }
    }
  }

  addFavorite(GameDetailModel? model) async {
    if (model == null) return;
    favorites.add(model);
    await cacheManager.setStringValue(
        PreferencesEnums.FAVORITES, jsonEncode(favorites));
    notifyListeners();
  }

  removeFavorite(int? id) async {
    if (id == null) return;
    favorites.removeWhere((element) => element.id == id);
    await cacheManager.setStringValue(
        PreferencesEnums.FAVORITES, jsonEncode(favorites));
    notifyListeners();
  }

  bool checkIsInFavorites(int? id) {
    if (id == null) return false;
    return favorites.any((element) => element.id == id);
  }
}
