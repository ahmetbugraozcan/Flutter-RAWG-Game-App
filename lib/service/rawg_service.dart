import 'dart:convert';

import 'package:appcentflutterassignment/core/constants/app_constants.dart';
import 'package:appcentflutterassignment/core/exceptions/rawg_exception.dart';
import 'package:appcentflutterassignment/models/game_detail_model.dart';
import 'package:appcentflutterassignment/models/game_model.dart';
import 'package:appcentflutterassignment/service/i_rawg_service.dart';
import 'package:http/http.dart' as http;

class RawgService extends IRawgService {
  static RawgService? _instance;

  static RawgService get instance => _instance ??= RawgService._init();

  RawgService._init();

  final AppConstants _appConstants = AppConstants.instance;
  @override
  Future<List<GameModel?>?> getGames(int page) async {
    var response = await http.get(
      Uri.parse(
        "${_appConstants.gamesEndPoint}?key=${_appConstants.apiKey}&page_size=${AppConstants.instance.paginationCount}&page=$page",
      ),
    );

    if (response.statusCode == 200 &&
        json.decode(response.body)["results"] is List) {
      return (json.decode(response.body)["results"] as List)
          .map((e) => GameModel.fromJson(e))
          .toList();
    } else {
      if (json.decode(response.body)["error"] != null) {
        throw RawgException(json.decode(response.body)["error"]);
      } else if (jsonDecode(response.body)["detail"] != null) {
        throw RawgException(jsonDecode(response.body)["detail"]);
      }
      return null;
    }
  }

  @override
  Future<GameDetailModel?> getGameDetails(int id) async {
    var response = await http.get(Uri.parse(
        "${_appConstants.gamesEndPoint}/$id?key=${_appConstants.apiKey}"));

    if (response.statusCode == 200) {
      return GameDetailModel.fromJson(json.decode(response.body));
    } else {
      if (json.decode(response.body)["error"] != null) {
        throw RawgException(json.decode(response.body)["error"]);
      } else if (jsonDecode(response.body)["detail"] != null) {
        throw RawgException(jsonDecode(response.body)["detail"]);
      }
      return null;
    }
  }
}
