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
  // favoriler gamedetail olduğu için bir daha request çıkmamıza gerek yok aşağıda bu durumu kontrol edeceğiz
  GameDetailModel? gameDetailModel;

  GameDetailsView({super.key, this.gameID, this.gameDetailModel});

  @override
  State<GameDetailsView> createState() => _GameDetailsViewState();
}

class _GameDetailsViewState extends State<GameDetailsView> {
  @override
  void initState() {
    super.initState();
    // bu durumda kişi favorilerden değil homedan id ile gelmiştir gamedetail çekilebilir
    if (widget.gameDetailModel == null && widget.gameID != null) {
      context.read<GameDetailsProvider>().getGameDetails(widget.gameID);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Builder(
        builder: (context) {
          // favorilerim kısmından gelen kişi gamedetailmodel ile geleceğinden direk render edebiliriz
          if (widget.gameDetailModel != null) {
            return buildGameDetailsPage(widget.gameDetailModel!, context);
          }

          // buraya düşen kişi homedan gelmiştir gamedetail id ile çekilebilir
          if (context.watch<GameDetailsProvider>().isLoading) {
            return const Center(child: CircularProgressIndicator());
          } else {
            if (context.watch<GameDetailsProvider>().gameDetailModel == null) {
              return Center(
                child: Text(context.read<GameDetailsProvider>().errorMessage ??
                    "An error occurred. Please try again later."),
              );
            } else {
              GameDetailModel gameDetail =
                  context.watch<GameDetailsProvider>().gameDetailModel!;
              return buildGameDetailsPage(gameDetail, context);
            }
          }
        },
      ),
    );
  }

  Scaffold buildGameDetailsPage(
      GameDetailModel gameDetail, BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [
              Stack(
                children: [
                  buildDetailsImage(gameDetail),
                  buildAddToFavoritesButton(gameDetail),
                  buildBackButton(),
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

  Widget buildBackButton() {
    return Positioned(
      top: 6,
      left: 6,
      child: Align(
        alignment: Alignment.topLeft,
        child: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
            shadows: [
              Shadow(
                blurRadius: 2.0,
                color: Colors.black,
              ),
            ],
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
    );
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
        onPressed: () async {
          if (context
              .read<FavoritesProvider>()
              .checkIsInFavorites(gameDetail.id)) {
            bool isRemoved = await context
                .read<FavoritesProvider>()
                .removeFavorite(gameDetail.id);
            if (isRemoved) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    "Removed from favorites",
                    style: context.textTheme.bodyText1,
                  ),
                  backgroundColor: Colors.red,
                ),
              );
            }
          } else {
            bool isAdded =
                await context.read<FavoritesProvider>().addFavorite(gameDetail);
            if (isAdded) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    "Added to favorites",
                    style: context.textTheme.bodyText1,
                  ),
                  backgroundColor: Colors.green,
                ),
              );
            }
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
