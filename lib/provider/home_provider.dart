import 'dart:developer';

import 'package:appcentflutterassignment/models/game_model.dart';
import 'package:appcentflutterassignment/repository/rawg_repository.dart';
import 'package:appcentflutterassignment/service/i_rawg_service.dart';
import 'package:flutter/cupertino.dart';

enum HomeViewState { SEARCH, IDLE }

class HomeProvider extends ChangeNotifier {
  ScrollController scrollController = ScrollController();
  IRawgService rawgService = RawgRepository.instance;
  HomeViewState viewType = HomeViewState.IDLE;

  HomeProvider() {
    // ilk açılışta verileri çek
    getAllGamesFirstTime();

    // Scrollcontroller sona ulaştığında diğer sayfaları çekmeye başla. page arttırma işlemini api servisi otomatik olarak yapacak
    scrollController.addListener(() {
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        if (!isPaginationLoading) getAllGamesPagination();
      }
    });

    searchFieldController.addListener(() {
      // eğer search texti üçten büyükse arama yap ve modu search moduna çevir değilse idle moduna çevir
      if (searchFieldController.text.length >= 3) {
        viewType = HomeViewState.SEARCH;
        filteredGamesList.clear();
        allGames?.forEach((element) {
          if (element?.name
                  ?.toLowerCase()
                  .contains(searchFieldController.text.toLowerCase()) ??
              false) {
            filteredGamesList.add(element);
          }
        });
      } else {
        viewType = HomeViewState.IDLE;
      }
      notifyListeners();
    });
  }

  TextEditingController searchFieldController = TextEditingController();

  int page = 1;
  // ilk veri çekişimizi kontrol eden loading
  bool isLoading = false;

  bool isPaginationLoading = false;

  // pagination için loadingleri kontrol edecek olan loading
  bool isFirstRequest = true;

  List<GameModel?>? allGames;
  List<GameModel?> filteredGamesList = [];

  Future<void> getAllGamesFirstTime() async {
    try {
      isLoading = true;
      allGames = await rawgService.getGames(page);
    } catch (e) {
      log(e.toString());
    } finally {
      isLoading = false;
      page++;
    }
    notifyListeners();
  }

  Future<void> getAllGamesPagination() async {
    try {
      isPaginationLoading = true;
      notifyListeners();

      List<GameModel?>? games = await rawgService.getGames(page);
      allGames!.addAll(games!);
    } catch (e) {
      log(e.toString());
    } finally {
      isPaginationLoading = false;
      page++;
    }
    notifyListeners();
  }

  void clearSearchField() {
    searchFieldController.clear();
    searchFieldController.text = "";
    viewType = HomeViewState.IDLE;
    notifyListeners();
  }
}
