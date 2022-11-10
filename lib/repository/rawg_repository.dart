import 'package:appcentflutterassignment/models/game_model.dart';
import 'package:appcentflutterassignment/models/game_detail_model.dart';
import 'package:appcentflutterassignment/service/i_rawg_service.dart';
import 'package:appcentflutterassignment/service/rawg_service.dart';

class RawgRepository extends IRawgService {
  final IRawgService _rawgService = RawgService.instance;

  static RawgRepository? _instance;
  static RawgRepository get instance => _instance ??= RawgRepository._init();
  RawgRepository._init();

  @override
  Future<GameDetailModel?> getGameDetails(int id) async {
    return await _rawgService.getGameDetails(id);
  }

  @override
  Future<List<GameModel?>?> getGames(int page) async {
    return await _rawgService.getGames(page);
  }
}
