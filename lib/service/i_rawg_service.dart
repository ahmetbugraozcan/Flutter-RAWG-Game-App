import 'package:appcentflutterassignment/models/game_detail_model.dart';
import 'package:appcentflutterassignment/models/game_model.dart';

abstract class IRawgService {
  Future<List<GameModel?>?> getGames(int page);
  Future<GameDetailModel?> getGameDetails(int id);
}
