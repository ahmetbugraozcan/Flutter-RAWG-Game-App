import 'package:appcentflutterassignment/core/constants/app_constants.dart';
import 'package:appcentflutterassignment/core/constants/enums/lottie_enums.dart';
import 'package:appcentflutterassignment/core/constants/enums/rawg_endpoint_enums.dart';

class Utils {
  final AppConstants _appConstants = AppConstants.instance;

  static Utils? _instance;

  static Utils get instance => _instance ??= Utils._init();

  Utils._init();

  String generateEndpoint(RawgEndpointEnums endpoint) =>
      _appConstants.baseUrl + endpoint.name;

  String getJSONLottiePath(LottieEnums lottieEnums) =>
      "${_appConstants.lottieFolderPath}${lottieEnums.name}.json";
}
