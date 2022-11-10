import 'package:appcentflutterassignment/core/init/cache/cache_manager.dart';
import 'package:appcentflutterassignment/core/init/theme/app_theme_light.dart';
import 'package:appcentflutterassignment/provider/all_providers.dart';
import 'package:appcentflutterassignment/views/splash/splash_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  await initializeApp();
  runApp(
    MultiProvider(
      providers: AllProviders.instance.dependItems(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'GameApp',
      theme: AppThemeLight.instance.themeData,
      home: const SplashView(),
    );
  }
}

initializeApp() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");
  await CacheManager.preferencesInit();
}
