import 'package:appcentflutterassignment/core/exceptions/rawg_exception.dart';
import 'package:appcentflutterassignment/models/game_detail_model.dart';
import 'package:appcentflutterassignment/repository/rawg_repository.dart';
import 'package:appcentflutterassignment/service/i_rawg_service.dart';
import 'package:flutter/cupertino.dart';

class GameDetailsProvider extends ChangeNotifier {
  final IRawgService _rawgService = RawgRepository.instance;

  bool isLoading = false;
  GameDetailModel? gameDetailModel;
  String? errorMessage;
  Future<void> getGameDetails(int? id) async {
    if (id == null) return;
    try {
      errorMessage = null;
      isLoading = true;
      gameDetailModel = await _rawgService.getGameDetails(id);
    } on RawgException catch (e) {
      errorMessage = e.message;
    } catch (e) {
      errorMessage = "An error occured";
    } finally {
      isLoading = false;
    }

    notifyListeners();
  }
}
