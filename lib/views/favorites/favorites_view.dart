import 'package:appcentflutterassignment/core/constants/enums/lottie_enums.dart';
import 'package:appcentflutterassignment/core/extensions/media_query_extensions.dart';
import 'package:appcentflutterassignment/core/extensions/theme_extension.dart';
import 'package:appcentflutterassignment/core/utils/utils.dart';
import 'package:appcentflutterassignment/models/game_detail_model.dart';
import 'package:appcentflutterassignment/models/game_model.dart';
import 'package:appcentflutterassignment/provider/favorites_provider.dart';
import 'package:appcentflutterassignment/widgets/cards/favorites_game_card.dart';
import 'package:appcentflutterassignment/widgets/cards/game_card.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

class FavoritesView extends StatelessWidget {
  const FavoritesView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Favorites")),
      body: Builder(
        builder: (context) {
          if (context.watch<FavoritesProvider>().favoritesIds.isEmpty) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  child: Lottie.asset(
                    Utils.instance.getJSONLottiePath(LottieEnums.notfound),
                    width: context.dynamicWidth(100),
                    height: context.dynamicHeight(40),
                  ),
                ),
                Text("No favorites found!",
                    style: context.textTheme.headlineSmall?.copyWith(
                        color: context.theme.primaryColor,
                        fontWeight: FontWeight.bold)),
              ],
            );
          } else {
            // if (context.watch<FavoritesProvider>().isLoading) {
            //   return const Center(child: CircularProgressIndicator());
            // }
            return Column(
              children: [
                Builder(builder: (context) {
                  if (context.watch<FavoritesProvider>().isLoading) {
                    return const LinearProgressIndicator();
                  }
                  return const SizedBox();
                }),
                Expanded(
                  child: ListView.builder(
                    itemCount:
                        context.watch<FavoritesProvider>().favorites.length,
                    itemBuilder: (context, index) {
                      return FavoritesGameCard(
                          gameDetailModel: context
                              .watch<FavoritesProvider>()
                              .favorites[index]);
                    },
                  ),
                ),
              ],
            );
          }
        },
      ),
    );
  }
}
