import 'package:appcentflutterassignment/provider/favorites_provider.dart';
import 'package:appcentflutterassignment/provider/game_details_provider.dart';
import 'package:appcentflutterassignment/provider/home_provider.dart';
import 'package:appcentflutterassignment/provider/tab_provider.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

class AllProviders {
  static final AllProviders _instance = AllProviders._init();

  static AllProviders get instance => _instance;

  AllProviders._init();

  List<SingleChildWidget> dependItems() => [
        ChangeNotifierProvider(
          create: (context) => TabProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => HomeProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => GameDetailsProvider(),
          lazy: true,
        ),
        ChangeNotifierProvider(
          create: (context) => FavoritesProvider(),
        ),
      ];
}
