import 'dart:developer';

import 'package:appcentflutterassignment/models/game_detail_model.dart';
import 'package:appcentflutterassignment/repository/rawg_repository.dart';
import 'package:appcentflutterassignment/service/i_rawg_service.dart';
import 'package:flutter/cupertino.dart';

class GameDetailsProvider extends ChangeNotifier {
  final IRawgService _rawgService = RawgRepository.instance;

  bool isLoading = false;
  GameDetailModel? gameDetailModel;
  Future<void> getGameDetails(int? id) async {
    if (id == null) return;
    try {
      isLoading = true;
      gameDetailModel = await _rawgService.getGameDetails(id);
    } catch (e) {
      log(e.toString());
    } finally {
      isLoading = false;
    }

    notifyListeners();
  }
}
