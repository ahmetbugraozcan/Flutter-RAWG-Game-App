import 'package:appcentflutterassignment/repository/rawg_repository.dart';
import 'package:appcentflutterassignment/service/i_rawg_service.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group("rawgApiTest", () {
    IRawgService rawgService = RawgRepository.instance;
    test("getGames", () async {
      var responseModel = await rawgService.getGames(1);
      expect(responseModel, isNotNull);
    });

    test("getGameDetails", () async {
      var responseModel = await rawgService.getGameDetails(3498);
      expect(responseModel, isNotNull);
    });
  });
}
