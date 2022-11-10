import 'package:appcentflutterassignment/core/constants/app_constants.dart';
import 'package:appcentflutterassignment/core/extensions/padding_extensions.dart';
import 'package:appcentflutterassignment/core/extensions/theme_extension.dart';
import 'package:appcentflutterassignment/models/game_detail_model.dart';
import 'package:appcentflutterassignment/provider/favorites_provider.dart';
import 'package:appcentflutterassignment/provider/game_details_provider.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class GameDetailsView extends StatefulWidget {
  int? gameID;
  GameDetailsView({super.key, this.gameID});

  @override
  State<GameDetailsView> createState() => _GameDetailsViewState();
}

class _GameDetailsViewState extends State<GameDetailsView> {
  @override
  void initState() {
    super.initState();
    context.read<GameDetailsProvider>().getGameDetails(widget.gameID);
  }

  @override
  Widget build(BuildContext context) {
    if (widget.gameID == null) {
      return Scaffold(
        body: Center(
          child: Text(
            context.read<GameDetailsProvider>().errorMessage ??
                "An error occurred. Please try again later.",
            textAlign: TextAlign.end,
          ),
        ),
      );
    } else {
      return Scaffold(
        body: Builder(
          builder: (context) {
            if (context.watch<GameDetailsProvider>().isLoading) {
              return const Center(child: CircularProgressIndicator());
            } else {
              if (context.watch<GameDetailsProvider>().gameDetailModel ==
                  null) {
                return Center(
                  child: Text(
                      context.read<GameDetailsProvider>().errorMessage ??
                          "An error occurred. Please try again later."),
                );
              } else {
                GameDetailModel gameDetail =
                    context.watch<GameDetailsProvider>().gameDetailModel!;
                return Scaffold(
                  body: SafeArea(
                    child: SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      child: Column(
                        children: [
                          Stack(
                            children: [
                              buildDetailsImage(gameDetail),
                              buildAddToFavoritesButton(gameDetail)
                            ],
                          ),
                          const SizedBox(height: 12),
                          buildDetailsBody(context, gameDetail)
                        ],
                      ),
                    ),
                  ),
                );
              }
            }
          },
        ),
      );
    }
  }

  CachedNetworkImage buildDetailsImage(GameDetailModel gameDetail) {
    return CachedNetworkImage(
      imageUrl:
          gameDetail.backgroundImage ?? AppConstants.instance.imageNotFoundUrl,
      height: 200,
      width: double.infinity,
      fit: BoxFit.fill,
    );
  }

  Positioned buildAddToFavoritesButton(GameDetailModel gameDetail) {
    return Positioned(
      right: 6,
      bottom: 6,
      child: IconButton(
        icon: Icon(
          Icons.favorite,
          color: context
                  .watch<FavoritesProvider>()
                  .checkIsInFavorites(gameDetail.id)
              ? Colors.red
              : Colors.white,
          shadows: const [
            Shadow(
              blurRadius: 10.0,
              color: Colors.black,
              offset: Offset(5.0, 5.0),
            ),
          ],
        ),
        onPressed: () {
          if (context
              .read<FavoritesProvider>()
              .checkIsInFavorites(gameDetail.id)) {
            context.read<FavoritesProvider>().removeFavorite(gameDetail.id);
          } else {
            context.read<FavoritesProvider>().addFavorite(gameDetail);
          }
        },
      ),
    );
  }

  Padding buildDetailsBody(BuildContext context, GameDetailModel gameDetail) {
    return Padding(
      padding: context.paddingLowHorizontal,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            gameDetail.name.toString(),
            style: context.textTheme.headlineSmall,
          ),
          Text(
            "Release Date ${gameDetail.released}",
            style: context.textTheme.labelLarge
                ?.copyWith(color: Colors.grey.shade600),
          ),
          Text(
            "Metacritic Rate ${gameDetail.metacritic}",
            style: context.textTheme.labelLarge
                ?.copyWith(color: Colors.grey.shade600),
          ),
          const SizedBox(height: 12),
          Padding(
            padding: context.paddingExtraLow,
            child: Text(
              gameDetail.descriptionRaw.toString(),
            ),
          ),
        ],
      ),
    );
  }
}
