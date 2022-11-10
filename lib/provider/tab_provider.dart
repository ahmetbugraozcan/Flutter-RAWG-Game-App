import 'package:appcentflutterassignment/views/favorites/favorites_view.dart';
import 'package:appcentflutterassignment/views/home/home_view.dart';
import 'package:flutter/cupertino.dart';

class TabProvider extends ChangeNotifier {
  int _currentIndex = 0;

  int get currentIndex => _currentIndex;

  void changeIndex(int index) {
    _currentIndex = index;
    notifyListeners();
  }

  TabProvider() {
    _currentIndex = 0;
  }

  List<Widget> pages = [
    const HomeView(),
    const FavoritesView(),
  ];
}
