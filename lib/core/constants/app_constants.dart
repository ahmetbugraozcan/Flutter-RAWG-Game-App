// Uygulama içinde kullanacağım değişkenleri tuttuğum class

import 'package:appcentflutterassignment/core/constants/enums/dotenv_key_enums.dart';
import 'package:appcentflutterassignment/core/constants/enums/rawg_endpoint_enums.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class AppConstants {
// lazy singleton pattern

  static AppConstants? _instance;

  static AppConstants get instance => _instance ??= AppConstants._init();

  AppConstants._init();

// API sabitleri
  String get baseUrl => 'https://api.rawg.io/api/';

  String get apiKey => dotenv.env[DotenvKeyEnums.RAWG_API_KEY.name] ?? "";

  String get gamesEndPoint => baseUrl + RawgEndpointEnums.games.name;

// dosya yolları
  String get lottieFolderPath => "assets/lottie/";

// bir istekte kaç veri geleceğini tuttuğum değişken
  int get paginationCount => 20;

  String get imageNotFoundUrl =>
      "https://www.nofshonit.co.il/static/placeholders/image-placeholder.png";
}
