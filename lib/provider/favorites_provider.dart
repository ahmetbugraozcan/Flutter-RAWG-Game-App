import 'dart:convert';
import 'package:appcentflutterassignment/core/constants/enums/preferences_enums.dart';
import 'package:appcentflutterassignment/core/init/cache/cache_manager.dart';
import 'package:appcentflutterassignment/models/game_detail_model.dart';
import 'package:appcentflutterassignment/models/game_model.dart';
import 'package:appcentflutterassignment/repository/rawg_repository.dart';
import 'package:appcentflutterassignment/service/i_rawg_service.dart';
import 'package:flutter/material.dart';

/// Senaryo: Favorilere eklenen oyunların verileri id olarak Cache'de tutulur. Daha sonra bu idler ile oyun detayları çekilir.
/// Bu nedenle favorilerim kısmındaki veriler [GameDetailModel] tipinde tutulur.
/// futures listesi request sonucundan gelen [GameDetailModel] verilerini tutar. Uygulama açıkken favorilere oyun
/// eklenir ise bu oyunun idsi Cache'e eklenirken oyunun kendisi statedeki favorites listesine eklenir.
class FavoritesProvider extends ChangeNotifier {
  CacheManager cacheManager = CacheManager.instance;
  final IRawgService _rawgService = RawgRepository.instance;
  bool isLoading = false;

  FavoritesProvider() {
    getFavoritesFromCache();
  }

  List<GameDetailModel?> favorites = [];
  List<int> favoritesIds = [];

  // Tüm idler ile game detail çekerken Futureları bu listeye ekleyip future.wait ile bekliyoruz.
  List<Future> favoriteGameFutures = [];

  /// Cache'de liste olarak idler tutuluyor. daha sonra burada bu idler ile tek tek gamedetailmodel çekiliyor.
  /// homeda [GameModel] kullanılırken burada yani favoriler sekmesinde [GameDetailModel] kullanılıyor.
  getFavoritesFromCache() async {
    isLoading = true;
    List<String>? stringList =
        CacheManager.instance.getStringListValue(PreferencesEnums.FAVORITES);

    if (stringList != null) {
      favoritesIds = stringList.map((e) => int.parse(e)).toList();

      favoriteGameFutures =
          favoritesIds.map((e) => _rawgService.getGameDetails(e)).toList();
      var favoriteGames = await Future.wait(favoriteGameFutures);
      for (var element in favoriteGames) {
        favorites.add(element);
      }
      isLoading = false;
    }
    notifyListeners();
  }

  Future<bool> addFavorite(GameDetailModel? model) async {
    if (model == null || model.id == null) return false;
    favoritesIds.add(model.id!);
    favorites.add(model);
    await cacheManager.setStringList(PreferencesEnums.FAVORITES,
        favoritesIds.map((e) => e.toString()).toList());
    notifyListeners();
    return true;
  }

  Future<bool> removeFavorite(int? id) async {
    if (id == null) return false;
    favoritesIds.removeWhere((element) => element == id);
    favorites.removeWhere((element) => element?.id == id);
    await cacheManager.setStringList(PreferencesEnums.FAVORITES,
        favoritesIds.map((e) => e.toString()).toList());
    notifyListeners();
    return true;
  }

  bool checkIsInFavorites(int? id) {
    if (id == null) return false;
    return favoritesIds.any((element) => element == id);
  }
}
