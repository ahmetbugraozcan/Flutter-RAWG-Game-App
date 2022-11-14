import 'package:appcentflutterassignment/core/constants/enums/lottie_enums.dart';
import 'package:appcentflutterassignment/core/extensions/media_query_extensions.dart';
import 'package:appcentflutterassignment/core/extensions/theme_extension.dart';
import 'package:appcentflutterassignment/core/utils/utils.dart';
import 'package:appcentflutterassignment/views/tab/tab_view.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const TabView()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: SizedBox.expand(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              child: Lottie.asset(
                Utils.instance.getJSONLottiePath(LottieEnums.gamelottie),
                height: context.dynamicHeight(30),
              ),
            ),
            Text(
              'RAWG',
              style: context.textTheme.headlineLarge,
            ),
            Text(
              "Discover games!",
              style: context.textTheme.bodySmall,
              textAlign: TextAlign.center,
            )
          ],
        ),
      )),
    );
  }
}
